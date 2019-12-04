prague = imread('inputSeamCarvingPrague.jpg');
ep= energy_img(prague);
ceph= cumulative_min_energy_map(ep, 'HORIZONTAL');
horz=find_horizontal_seam(ceph);
view_seam(prague,horz,'HORIZONTAL'); 
