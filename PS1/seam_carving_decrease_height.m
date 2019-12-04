prague = imread('inputSeamCarvingPrague.jpg');

for i = 1:50
    ep=energy_img(prague);
    [prague,~]=decrease_height(prague,ep);
end
imwrite(prague,'outputReducedHeightPrague.jpg');

mall = imread('inputSeamCarvingMall.jpg');

for i = 1:50
    em=energy_img(mall);
    [mall,~]=decrease_height(mall,em);
end
imwrite(mall,'outputReducedHeightMall.jpg');

