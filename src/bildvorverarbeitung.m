function img_out = bildvorverarbeitung(img_in,para)
%% ****************************************************************
% ----------------------- Bildvorverarbeitung  ------------------------------
% ***************************************************************************
fprintf('Bildvorverarbeitung ...\n');
sigma_gauss = 5;
gaussian1 = fspecial('Gaussian', 21, sigma_gauss);
gaussian2 = fspecial('Gaussian', 21, sigma_gauss*1.6);  %imgaussfilt
dog_filter = gaussian1-gaussian2;
for i = 1:size(img_in,3)
    %------------------------ Bilddrehen und Bildbeschneiden
    img_temp = imrotate(img_in, para.rot);
    img_out = img_temp (para.x1:para.x2,para.y1:para.y2);
    %------------------------ Difference of Gaussians filter
    img_out(:,:,i) = conv2(double(img_out(:,:,i)), dog_filter, 'same');
end
img_out = uint8(img_out);
%------------------------ Beleuchtungseffektkorrektur
end