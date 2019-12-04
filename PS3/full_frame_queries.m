clear 
close all

addpath('./');
framesdir = './frames/';
siftdir = './sift/';
load('kMeans.mat');
fnames = dir([siftdir '/*.mat']);

%first find histograms as bag-of-words using kmeans 
%choose 3 frames fron the video dataset as queries
%display:: query frame and its M = 5 most similar frames(in rank order)
% based on bag of words histograms

%find histogram
D = [];
[m,n] = size(means);
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

%choose 3 frames from the video dataset

frames = [600,61,200];

% display query frame and its M = 5 most similar frames(in rank order)
% calculate the smilarity use bag of words

for j = 1:length(frames)   
    %load query frames image
    t=[siftdir '/' fnames(frames(j)).name];
    load(t);
    imname = [framesdir '/' imname];
    im = imread(imname);
    figure;
    subplot(2,3,1);
    imshow(im);
    title(strcat('Query Image: ',imname));
    % find smilarity
    frame_bagWord = bag_words(frames(j),:);
    frame_bagWord_matrix = repmat(frame_bagWord', 1, length(bag_words));
    sim = corr(bag_words',frame_bagWord_matrix);
    sim(isnan(sim)) = 0;
    [sortedDis,simIm] = sort(sim,'descend');
    %display the first five
    for i=2:6
       fname = [siftdir '/' fnames(simIm(i)).name];
       load(fname);
       imname = [framesdir '/' imname];
       im = imread(imname);
       subplot(2,3,i);
       imshow(im);
       title({strcat('Result: ', num2str(i-1)),imname,strcat('Similarity: ',num2str(sortedDis(i)))});
    end   
end





