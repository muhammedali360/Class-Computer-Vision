 
 
 m2 = imread('m2.jpg');
 [row,col,~]=size(m2);
 subplot(3,3,1);
 imshow(m2);
 title('Original M2');
 xlabel('623x1000');
 orig=m2;
 for i = 1:150
     em=energy_img(m2);
     [m2,~]=decrease_height(m2,em);
 end
 subplot(3,3,2)
 imshow(m2);
 title('M2 resized');
 xlabel('473x1000');
 
 
 subplot(3,3,3)
 imshow(imresize(orig,[row-150, col]));
 title('M2 imresized');
 xlabel('473x1000');
% imwrite(m2,'reduced_m2.jpg');
 


 pika = imread('pikachu.jpg');
 [row,col,~]=size(pika);
 subplot(3,3,4);
 imshow(pika);
 title('Original Pikachu');
 xlabel('800x1200');
 orig=pika;
 for i = 1:100
     em=energy_img(pika);
     [pika,~]=decrease_height(pika,em);
 end
 subplot(3,3,5)
 imshow(pika);
 title('Pikachu resized');
 xlabel('700x1200');
 
 
 subplot(3,3,6)
 imshow(imresize(orig,[row-100, col]));
 title('Pikachu imresized');
 xlabel('700x1200');
 
% %imwrite(pika,'reduced_pika.jpg');


 davis = imread('davis.jpeg');
 
 [row,col,~]=size(davis);
 subplot(3,3,7);
 imshow(davis);
 title('Original Davis Logo');
 xlabel('265x564');
 orig=davis;
 for i = 1:50
     em=energy_img(davis);
     [davis,~]=decrease_width(davis,em);
 end
 subplot(3,3,8)
 imshow(davis);
 title('Davis resized');
 xlabel('265x514');
 
 
 subplot(3,3,9)
 imshow(imresize(orig,[row, col-50]));
 title('Davis imresized');
 xlabel('265x514');
 
% %imwrite(davis,'reduced_davis.jpg');