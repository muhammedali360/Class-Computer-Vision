clear all;
H=computeH('cc1.mat','cc2.mat');%here we verify the homography works by going from cc1->cc2
t1=importdata('cc1.mat');
[a,b]=size(t1);
tranf=zeros(a,b);
for i = 1:b

   pixel=[t1(2,i) t1(1,i) 1]';
   tran=H * pixel;
   tranf(1,i)=tran(2,1)/tran(3,1);
   tranf(2,i)=tran(1,1)/tran(3,1);
    
end

inputIm=double(importdata('crop2.jpg'));
figure;
imagesc(uint8(inputIm));
hold on;
title('cc1->cc2 Using homography');
scatter(tranf(1,:),tranf(2,:));



%repeat to go from cc2 ->cc1 using inverse of homography
t2=importdata('cc2.mat');
tranf=zeros(a,b);
for i = 1:b

   pixel=[t2(2,i) t2(1,i) 1]';
   tran=inv(H) * pixel;
   tranf(1,i)=tran(2,1)/tran(3,1);
   tranf(2,i)=tran(1,1)/tran(3,1);
    
end

inputIm=double(importdata('crop1.jpg'));
figure;
imagesc(uint8(inputIm));
hold on;
title('cc2->cc1 Using inverse homography');
scatter(tranf(1,:),tranf(2,:));
