function verticalSeam = find_vertical_seam(cumulativeEnergyMap)
    [row,col] = size(cumulativeEnergyMap);
    vert = zeros(row,1);
    [~,vert(row)]=min(cumulativeEnergyMap(row,:));
    
    for i=row-1:-1:1
        prev = vert(i+1);
        if prev == 1
            [~,vert(i)] = min([cumulativeEnergyMap(i,prev),cumulativeEnergyMap(i,prev+1)]);
            continue
        end
        if prev == col
            [~,temp] = min([cumulativeEnergyMap(i,prev-1),cumulativeEnergyMap(i,prev)]);
            vert(i)=prev+temp-2; %adjustments because the index returned is relative to the above array ie only 1 or 2
            continue
        end
        [~,temp]= min([cumulativeEnergyMap(i,prev-1),cumulativeEnergyMap(i,prev),cumulativeEnergyMap(i,prev+1)]);
        vert(i) = prev+temp-2;
    end
    verticalSeam=vert;
end

