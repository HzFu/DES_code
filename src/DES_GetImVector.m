function [ LABvector, DisVector] = DES_GetImVector(RGB_img)
% Get the vector of image

[ScaleH, ScaleW, ~] = size(RGB_img);%Scale Height

img = colorspace('Lab<-RGB',RGB_img);  %RGB -> Lab

LABvector=zeros( ScaleH*ScaleW,3);
DisVector=zeros( ScaleH*ScaleW,1);

LABvector(:,1) = reshape(img(:, :, 1), ScaleH*ScaleW, 1);
LABvector(:,2) = reshape(img(:, :, 2), ScaleH*ScaleW, 1);
LABvector(:,3) = reshape(img(:, :, 3), ScaleH*ScaleW, 1);
for j=1:ScaleH 
    for i=1:ScaleW 
        DisVector(j +(i-1)*ScaleH)=round(sqrt((i-ScaleW/2)^2+(j-ScaleH/2)^2));
    end
end


end

