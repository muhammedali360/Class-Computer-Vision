 prague = imread('inputSeamCarvingPrague.jpg');
 en=energy_img(prague);
 cen=cumulative_min_energy_map(en,'HORIZONTAL');
 imagesc(cen);
