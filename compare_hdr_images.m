function l2 = compare_hdr_images(filename1, filename2)

hdrimage1 = hdrread(filename1);
hdrimage2 = hdrread(filename2);

sizex = size(hdrimage1,1);
sizey = size(hdrimage1,2);

if (sizex ~= size(hdrimage2,1) || sizey ~= size(hdrimage2,2))
    display('sizes do not match');
    exit;
else
    display('images were succesfully loaded');
end

total_diff = 0;
total_sum = 0;

%conversion to Lab space
%converting function by Yossi Rubner

converted1 = RGB2Lab(hdrimage1);
converted2 = RGB2Lab(hdrimage2);

%colour diff according to CIE76

for j = 1:sizey,
    for i= 1:sizex,
        
        L_diff = converted1(i, j, 1) - converted2(i, j, 1);
        a_diff = converted1(i, j, 2) - converted2(i, j, 2);
        b_diff = converted1(i, j, 3) - converted2(i, j, 3);
        totdiffsq = L_diff * L_diff + a_diff * a_diff + b_diff * b_diff;
        totdiff = sqrt(totdiffsq);
        
        L_sum = converted1(i, j, 1) + converted2(i, j, 1);
        a_sum = converted1(i, j, 2) + converted2(i, j, 2);
        b_sum = converted1(i, j, 3) + converted2(i, j, 3);
        totsumsq = L_sum * L_sum + a_sum * a_sum + b_sum * b_sum;
        totsum = sqrt(totsumsq);
         
        total_diff = total_diff + totdiff;
        total_sum = total_sum + totsum;
    end
end

total_diff = total_diff / (sizex * sizey);
total_sum = total_sum / (sizex * sizey);

l2 = 2 * total_diff / total_sum;