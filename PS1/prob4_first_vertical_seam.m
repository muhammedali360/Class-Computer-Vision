prague = imread('inputSeamCarvingPrague.jpg');
ep= energy_img(prague);
cepv = cumulative_min_energy_map(ep, 'VERTICAL');
vert=find_vertical_seam(cepv);
view_seam(prague,vert,'VERTICAL'); 
