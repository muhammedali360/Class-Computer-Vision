 pika = imread('pikachu.jpg');
 res = seam_carving_increase_height(pika);%increase by 100
 imwrite(res,'tallerchu.jpg');
  
 
 prague = imread('inputSeamCarvingPrague.jpg');
 res = seam_carving_increase_height(prague); %increase by 100
 imwrite(res,'tallerPrague.jpg');
 
 m2 = imread('m2.jpg');
 res = seam_carving_increase_width(m2); %increase by 50
 imwrite(res,'longerm2.jpg');