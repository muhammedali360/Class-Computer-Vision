function horizontalSeam = find_horizontal_seam(cumulativeEnergyMap)
    [~,col] = size(cumulativeEnergyMap);
    horz = zeros(col,1);
    [~,horz(col)]=min(cumulativeEnergyMap(:,col));
    
    for i=col-1:-1:1
        prev = horz(i+1);
        if prev == 1
            [~,horz(i)] = min([cumulativeEnergyMap(prev,i),cumulativeEnergyMap(prev+1,i)]);
            continue
        end
        if prev == col
            [~,temp] = min([cumulativeEnergyMap(prev-1,i),cumulativeEnergyMap(prev,i)]);
            horz(i)=prev+temp-2; %adjustments because the index returned is relative to the above array ie only 1 or 2
            continue
        end
        [~,temp]= min([cumulativeEnergyMap(prev-1,i),cumulativeEnergyMap(prev,i),cumulativeEnergyMap(prev+1,i)]);
        horz(i) = prev+temp-2;
    end
    horizontalSeam=horz;
end
