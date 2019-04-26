clear;
close all;

doge = imread('dog.jpeg');


subplot(3,2,1);
d1=rgb2gray(doge);
imshow(d1);
title('A) Grayscale');


subplot(3,2,2);
d2=imcomplement(d1);
imshow(d2);
title('B) Negative');


subplot(3,2,3);
d3=fliplr(doge);
imshow(d3);
title('C) Mirror');

subplot(3,2,4);
red=doge(:,:,1);
blue=doge(:,:,3);
d4=cat(3,blue,doge(:,:,2),red);
imshow(d4);
title('D) RED/BLUE');

subplot(3,2,5);
X=double(d3);
Y=double(doge);
d5=uint8((X+Y)/2);
imshow(d5);
title('E) AVG w/ Mirror');



subplot(3,2,6);
[p,q,z] = size(doge);
arr = randi([0,255],p,q,'uint8');
d6=d1-uint8(arr);
bel=find(d6<0);
abv=find(d6>255);
doge(bel)=0;
doge(abv)=255;
imshow(d6);
title('C) Rand Subtract');

