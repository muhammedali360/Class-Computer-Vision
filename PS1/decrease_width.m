function [reducedColorImg,reducedEnergyImg] = decrease_width(im,energyImg)
    cumulative = cumulative_min_energy_map(energyImg, 'VERTICAL');
    seam = find_vertical_seam(cumulative);
    [row,col,~]=size(im);
    nim=uint8(zeros(row,col-1,3));
    nenergyImg=zeros(row,col-1);
    
    for i = 1:row
        seampix=seam(i);
        if seampix ==1
            nim(i,:,1) = im(i,seampix+1:col,1);
            nim(i,:,2) = im(i,seampix+1:col,2);
            nim(i,:,3) = im(i,seampix+1:col,3);
            nenergyImg(i,:) = energyImg(i,seampix+1:col);
            continue
        end
        if seampix==col
            nim(i,:,1) = im(i,1:seampix-1,1);
            nim(i,:,2) = im(i,1:seampix-1,2);
            nim(i,:,3) = im(i,1:seampix-1,3);
            nenergyImg(i,:) = energyImg(i,1:seampix-1);
            continue
        end
        red = im(i,:,1);
        green = im(i,:,2);
        blue = im(i,:,3);
        energ = energyImg(i,:);
        
        red(seampix)=[];
        green(seampix)=[];
        blue(seampix)=[];
        energ(seampix)=[];
       
        nim(i,:,:)= cat(3,red,green,blue);
        nenergyImg(i,:) = energ;

    end
    reducedColorImg = nim;
    reducedEnergyImg= nenergyImg;
end