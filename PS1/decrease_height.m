function [reducedColorImg,reducedEnergyImg] = decrease_height(im,energyImg)
    cumulative = cumulative_min_energy_map(energyImg, 'HORIZONTAL');
    seam = find_horizontal_seam(cumulative);
    [row,col,~]=size(im);
    nim=uint8(zeros(row-1,col,3));
    nenergyImg=zeros(row-1,col);
    
    for i = 1:col
        seampix=seam(i);
        if seampix ==1
            nim(:,i,1) = im(seampix+1:row,i,1);
            nim(:,i,2) = im(seampix+1:row,i,2);
            nim(:,i,3) = im(seampix+1:row,i,3);
            nenergyImg(:,i) = energyImg(seampix+1:row,i);
            continue
        end
        if seampix==row
            nim(:,i,1) = im(1:seampix-1,i,1);
            nim(:,i,2) = im(1:seampix-1,i,2);
            nim(:,i,3) = im(1:seampix-1,i,3);
            nenergyImg(:,i) = energyImg(1:seampix-1,i);
            continue
        end
        red = im(:,i,1);
        green = im(:,i,2);
        blue = im(:,i,3);
        energ = energyImg(:,i);
        
        red(seampix)=[];
        green(seampix)=[];
        blue(seampix)=[];
        energ(seampix)=[];
       
        nim(:,i,:)= cat(3,red,green,blue);
        nenergyImg(:,i) = energ;

    end
    reducedColorImg = nim;
    reducedEnergyImg= nenergyImg;
end