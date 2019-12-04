clear
close all
load('twoFrameData.mat');
oninds = selectRegion(im1,positions1);

imGray = rgb2gray(im1);
im = rgb2gray(im2);
[r,d] = size(oninds);
[m,n] = size(descriptors2);

D = [];
for i = 1:r
    index = oninds(i,1);
    patch1 = getPatchFromSIFTParameters(positions1(index,:), scales1(index), orients1(index), imGray); %grab the first patch in oninds
    A = zeros(m,1);
    for j = 1:m
       z = distSqr(descriptors1(index,:)',descriptors2(j,:)');%distance from ith patch(im1) to jth in im2. VVV
       A(j,1) = z;                                            %|-> Transposed because distsqr needs it like that      
    end
    [var,ind] = mink(A',2); %transpose because A is column
    if var(2)/var(1) > 1.4 % NEW AND IMPROVED threshold
        D = [D ind(1)]; %concatenate the indicies
    end    
    
    %x = distSqr(positions1(index,:), positions2(ind,:));  <<<--- we dont need to use / find actual distance
    %D(i,1) = x;
end
[~,q]=size(D);
positionF = zeros(q,2);
scaleF = zeros(q,1);
orientF = zeros(q,1);
for k = 1:q
    i=D(1,k);
    positionF(k,:) = positions2(i,:);
    scaleF(k,1) = scales2(i,1);
    orientF(k,1) = orients2(i,1);
end

imshow(im2);
displaySIFTPatches(positionF,scaleF,orientF,im2);


