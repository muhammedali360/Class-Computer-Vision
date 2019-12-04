prague = imread('inputSeamCarvingPrague.jpg');

for i = 1:100
    ep=energy_img(prague);
    [prague,~]=decrease_width(prague,ep);
end
imwrite(prague,'outputReducedWidthPrague.jpg');

mall = imread('inputSeamCarvingMall.jpg');

for i = 1:100
    em=energy_img(mall);
    [mall,~]=decrease_width(mall,em);
end
imwrite(mall,'outputReducedWidthMall.jpg');

