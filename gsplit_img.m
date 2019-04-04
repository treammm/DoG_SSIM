function [ksplit_img] = gsplit_img(input_img, kband)

% fprintf('compute gsplit_img~\n'); % for debug
img = 255*im2double(input_img);
img = rgb2ycbcr(img);
imgY = img(:,:,1);
width = size(imgY,2);
height = size(imgY,1);
kval = 1.6;

gspace_img = zeros(height,width,kband);
ksplit_img = zeros(height,width,kband);
gspace_img(:,:,1)=imgY;

for band = 2:kband
    sigma = kval^(band-2); 
    ws = ceil(2*(3*sigma+1));
    h = fspecial('gaussian',ws,sigma);    
    gspace_img(:,:,band) = imfilter(gspace_img(:,:,1),h); 
end

ksplit_img(:,:,kband) = gspace_img(:,:,kband);

for band = 1:kband-1
    ksplit_img(:,:,band) = gspace_img(:,:,band) - gspace_img(:,:,band+1);
end
