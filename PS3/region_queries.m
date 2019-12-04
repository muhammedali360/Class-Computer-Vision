%Select query regions from within 4 frames
%to demonstrate the retrieved frames 
%when only a portion of the SIFT descriptors are used to form a bag of words.
%Display:: 
%each query region (marked in the frame as a polygon) 
%and its M=5 most similar frames.
clear 
close all

addpath('./');
framesdir = './frames/';
siftdir = './sift/';
load('kMeans.mat');
fnames = dir([siftdir '/*.mat']);

%select 4 frames

frames = [600,50,60,90];

%find histogram
D = [];
for i=1:length(fnames)
    %load descriptors from the loadDataExample
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'descriptors'); 
    %find distance and sort them by finding minimum distance and their
    %corresponse index
    D = distSqr(descriptors',means');
    [r,c] = size(D);
    for k = 1:r
        [~,minI] = min(D(k,:));
        A(k,1) = minI;
    end
    %histogram 
    bag_words(i,:) = histcounts(A,1:75);   
end



for j = 1:length(frames)  
    %load query frames image
    t=[siftdir '/' fnames(frames(j)).name];
    load(t);
    imname = [framesdir '/' imname];
    im = imread(imname);
    %select regions
    oninds = selectRegion(im,positions);
    [r,~] = size(oninds);
    
    %question--------how to display the region as polygons in the picture?
    
    % find smilarity
    frames_bagWords = bag_words(frames(j),:); % found histogram of the frames's bag_words
    %find oninds similarity
    descriptors_oninds = [];
    for k = 1:r
        index = oninds(k);
        descriptors_oninds = [descriptors_oninds; descriptors(index,:)];
    end
    B = dist2(descriptors_oninds, means);
    [~,minIB] = min(B,[],2);
    bag_words_oninds = histcounts(minIB,1:75);
    oninds_bagWord_matrix = repmat(bag_words_oninds', 1, length(bag_words));
    sim = corr(bag_words',oninds_bagWord_matrix);
    sim(isnan(sim)) = 0;
    [sortedDis,simIm] = sort(sim,'descend');
    
    for i=2:6
       fname = [siftdir '/' fnames(simIm(i)).name];
       load(fname);
       imname = [framesdir '/' imname];
       im = imread(imname);
       subplot(2,3,i);    
       imshow(im);
       title({strcat('Result: ', num2str(i-1)),imname,strcat('Distance: ',num2str(sortedDis(i)))});
    end   
    prompt = 'please press enter';
    [~]= input(prompt);
    close all;
end

