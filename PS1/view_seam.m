function seam = view_seam(im,seam,seamDirection)
    [row,col,~] = size(im);
    if strcmp(seamDirection,'HORIZONTAL')
        for i = 1:col
            im(seam(i),i,:) = [255,0,0];
        end
    end
    if strcmp(seamDirection,'VERTICAL')
        for i = 1:row
            im(i,seam(i),:) = [255,0,0];
        end
    end
    imagesc(im)
end