function cumulativeEnergyMap = cumulative_min_energy_map(energyImg,seamDirection)
    map = energyImg;
    [row,col] = size(map);
    
    if strcmp(seamDirection, 'HORIZONTAL')
        for c = 2:col
            for r = 1:row
                if (r == 1)
                    map(r,c) = energyImg(r,c) + min([map(r,c-1),map(r+1,c-1)]);
                    continue
                end
                if (r==row)
                    map(r,c) = energyImg(r,c) + min([map(r,c-1),map(r-1,c-1)]);
                    continue
                end
                map(r,c) = energyImg(r,c)+ min([map(r+1,c-1),map(r,c-1),map(r-1,c-1)]);
            end
        end
    end
                    
    if strcmp(seamDirection, 'VERTICAL')
        for r = 2:row
            for c = 1:col
                if (c == 1)
                    map(r,c) = energyImg(r,c) + min([map(r-1,c),map(r-1,c+1)]);
                    continue
                end
                if (c ==col)
                    map(r,c) = energyImg(r,c) + min([map(r-1,c),map(r-1,c-1)]);
                    continue
                end
                map(r,c) = energyImg(r,c)+ min([map(r-1,c),map(r-1,c+1),map(r-1,c-1)]);
            end
        end
    end
    %imagesc(map);
    cumulativeEnergyMap = map;    
end 