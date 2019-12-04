

function  final= seam_carving_increase_height(prague)

    %originially wrote the code for prague, lol
    p2=prague;
    [row,col,~]=size(prague);
    temp = zeros(100,col);
    for i = 1:100
        ep=energy_img(prague);
        cep = cumulative_min_energy_map(ep,'HORIZONTAL');
        temp(i,:) = find_horizontal_seam(cep);
        [prague,~]=decrease_height(prague,ep);
    end



    for i = 1:100
        res = uint8( zeros(row+i,col,3));
        for j = 1:col
            if j == col
            seampix=temp(i,j);

            red = p2(:,j,1).';
            green = p2(:,j,2).';
            blue = p2(:,j,3).';

            ar= mean([red(seampix),red(seampix-1)]);
            ag= mean([green(seampix),green(seampix-1)]);
            ab= mean([blue(seampix),blue(seampix-1)]);

            newr=  uint8([red(1:seampix-1) ar red(seampix:end)].');
            newg= uint8( [green(1:seampix-1) ag green(seampix:end)].');
            newb= uint8([blue(1:seampix-1) ab blue(seampix:end)].');
            res(:,j,:)= cat(3,newr,newg,newb);
            continue
            end
        seampix=temp(i,j);

        red = p2(:,j,1).';
        green = p2(:,j,2).';
        blue = p2(:,j,3).';

        ar= mean([red(seampix),red(seampix+1)]);
        ag= mean([green(seampix),green(seampix+1)]);
        ab= mean([blue(seampix),blue(seampix+1)]);

        newr=  uint8([red(1:seampix) ar red(seampix+1:end)].');
        newg=  uint8( [green(1:seampix) ag green(seampix+1:end)].');
        newb=  uint8([blue(1:seampix) ab blue(seampix+1:end)].');
        res(:,j,:)= cat(3,newr,newg,newb);
        end
    p2 = res;
    end
    final = res;
end