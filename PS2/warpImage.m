function [warpIm,mergeIm]= warpImage(inputIm,refIm,H)
inputIm=double(importdata(inputIm));
refIm=double(importdata(refIm));
%multiply Homography times corners to find max bounds.
[a,b,~]=size(inputIm);
[a1,b1,~]=size(refIm);%a1 is y dimension
corner1=[1,1,1]';
corner2=[1,a,1]';%a corresponds to rows aka y. so this is x=1 y= max
corner3=[b,1,1]';
corner4=[b,a,1]';
%multiplying homograpgy times corners
c1=H*corner1;
c2=H*corner2;
c3=H*corner3;
c4=H*corner4;
%normalize the x,y of warped dimensions.
c1(1,1)=c1(1,1)/c1(3,1);
c1(2,1)=c1(2,1)/c1(3,1);
c2(1,1)=c2(1,1)/c2(3,1);
c2(2,1)=c2(2,1)/c2(3,1);
c3(1,1)=c3(1,1)/c3(3,1);
c3(2,1)=c3(2,1)/c3(3,1);
c4(1,1)=c4(1,1)/c4(3,1);
c4(2,1)=c4(2,1)/c4(3,1);

%compute the bounding box
xMin=min([1 c1(1,1) c2(1,1) c3(1,1) c4(1,1)]);
xMax=max([b1 c1(1,1) c2(1,1) c3(1,1) c4(1,1)]);

yMin=min([1 c1(2,1) c2(2,1) c3(2,1) c4(2,1)]);
yMax=max([a1 c1(2,1) c2(2,1) c3(2,1) c4(2,1)]);

xshift = 1- xMin; %amounts we need to shift to base everything from 1
yshift= 1-yMin ;

%bxMin=xMin+xshift;%bounding box 
bxMax=round(xMax+xshift);
%byMin=yMin+yshift;
byMax=round(yMax+yshift);

finImg=zeros(bxMax,byMax,3);%create all black bounding box

%[nx,ny]=meshgrid(1:bxMax,1:byMax);%create meshgrid to inverse warp

tranx=zeros(byMax,bxMax);%this will be the translated coordinates of inv warp
trany=zeros(byMax,bxMax);
for i = 1:byMax
    for j = 1:bxMax
        pixel=[j-round(xshift) i-round(yshift) 1]';
        tran=inv(H) * pixel;
        tranx(i,j)=tran(1,1)/tran(3,1);
        trany(i,j)=tran(2,1)/tran(3,1);
    end
end
[na,nb]=size(tranx);
tranx=tranx+xshift*ones(na,nb);%shift before interpolation
trany=trany+yshift*ones(na,nb);

Vq1=interp2(inputIm(:,:,1),tranx,trany);%interpolate channel by channel
Vq2=interp2(inputIm(:,:,2),tranx,trany);
Vq3=interp2(inputIm(:,:,3),tranx,trany);
vq=cat(3,Vq1,Vq2,Vq3);%combining the chanels
nans=isnan(vq);%indicies where we do not have a value

for i=1:na
    for j=1:nb
        if nans(i,j)==0 %basically if we do have a value, we place it in our bounding box
            finImg(i,j,:)=vq(i,j,:); 
        end
    end
end
%[a1,b1,c1]=size(refIm)\\ Now we paste on the ref image to its proper location
for i =1:a1
    for j=1:b1
        finImg(i+round(yshift),j+round(xshift),:)=refIm(i,j,:);
    end
end
mergeIm=finImg;
warpIm=vq;
imagesc(uint8(finImg));
end