
    clear;  
    close all;
    
    doc=matfile("PS0_A.mat");
    
    figure(1);
    A1 = doc.A;
    A2 = A1(:);
    A3 = sort(A2, 'descend');
    X= 1:length(A3);
    plot(X, A3);
    
    figure(2);
    B = histogram(A3,10);
    
    
    figure(3);
    Z=A1(51:100,1:50);
    imagesc(Z);
      
    figure(4);
    M=mean(A1);
    W=A1-M;
    imagesc(Z);
    
    figure(5);
    M=mean(A1);
    R=A1>M;
    red = R*255;
    green=zeros(100,100);
    blue=zeros(100,100);
    Y=cat(3,red,green,blue);
    imshow(Y);
