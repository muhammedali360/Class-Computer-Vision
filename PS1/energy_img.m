function energyImg = energy_img(im)
my = fspecial('sobel');
mx = -my';
%mx = [-1,1]; %alternate methods
%my = [-1;1];
y = imfilter(double(rgb2gray(im)),my);
x = imfilter(double(rgb2gray(im)),mx);
energyImg = sqrt(x.^2 + y.^2);
%imagesc(energyImg)
end

