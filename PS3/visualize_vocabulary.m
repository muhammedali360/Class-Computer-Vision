addpath('./');
framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);

r=randi(length(fnames),500,1); %r will contain the index of random 500 images
voc=[]; %our vocabulary of all patches from 500 images
vocPositions=[];
vocScales=[];
vocOrients=[];
vocFile=[];
for i=1:500 %build vocabulary from images
    t=[siftdir '/' fnames(r(i)).name];
    load(t,'imname','descriptors','positions','scales','orients');
    voc=[voc ; descriptors];
    vocPositions=[vocPositions;positions];
    vocScales=[vocScales;scales];   %Saving all the features of vocabulary for later use
    vocOrients=[vocOrients;orients];
    vocFile=[vocFile; ones(size(descriptors,1),1).*i];
end

[membership,means1,rms]=kmeansML(1000,voc'); %find 1000 kmeans
means=means1';%transpose result
save('kMeans.mat', 'means');

[s1,~]=size(membership);
obj=zeros(1000,1);
for i=1:s1
    obj(membership(i))=obj(membership(i))+1; % count how many times each of the 1000 words appears in all the patches in all the images we chose
end

[~,index1]=max(obj);
obj(index1)=0;%clear that variable so we can find next most common word
[~,index1]=max(obj); 
obj(index1)=0; %set index1 as second most common word, and remove clear that variable so we can find next one
[~,index2]=max(obj); 
obj(index2)=0; %remove the third most common word too
[~,index2]=max(obj); 
obj(index2)=0; %remove the fourth most common word too
[~,index2]=max(obj); 
obj(index2)=0; %remove the fifth most common word too
[~,index2]=max(obj); 
%now we have the second and sixth most common words to create some variance
word1=means(index1,:);
word2=means(index2,:); %find the actual word in our means
search1=find(membership==index1); %search for this word in our patches
search2=find(membership==index2);

A=zeros(size(search1,1),1);
for i=1:size(search1,1) 
    z=distSqr(word1',voc(search1(i,1),:)');
    A(i,1) = z;         %store distnace of each vocab patch to our word
end
figure;
for i=1:25 %plot top 25 patches
    [~,index]=min(A');       %find index of closest patch to our word
    A(index,1)=1;
    index=search1(index);    %trasnlate max of A index to its corresponding voc index (the closest patch)
    t=[siftdir '/' fnames(r(vocFile(index))).name];
    load(t,'imname');
    gray=rgb2gray(imread([framesdir '/' imname]));
    patch = getPatchFromSIFTParameters(vocPositions(index,:),vocScales(index,:),vocOrients(index,:),gray); 
    subplot(5,5,i); %plotting the patch from vocab and its corresponding gray img
    imshow(patch);
end

%repeat for next word
A=zeros(size(search2,1),1);
for i=1:size(search2,1) 
    z=distSqr(word2',voc(search2(i,1),:)');
    A(i,1) = z;             %store distnace of each vocab patch to our word
end
figure;
for i=1:25 %plot top 25 patches
    [~,index]=min(A');       %find index of closest patch to our word
    A(index,1)=1;
    index=search2(index);    %trasnlate max of A index to its corresponding voc index (the closest patch)
    t=[siftdir '/' fnames(r(vocFile(index))).name];
    load(t,'imname');
    gray=rgb2gray(imread([framesdir '/' imname]));
    patch = getPatchFromSIFTParameters(vocPositions(index,:),vocScales(index,:),vocOrients(index,:),gray); 
    subplot(5,5,i); %plotting the patch from vocab and its corresponding gray img
    imshow(patch);
end

