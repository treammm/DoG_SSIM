function X = featurev1(IRef,IDis,S)
%% rgb2yiq
[YR,IR,QR] = rgb2yiq(IRef);
[YD,ID,QD] = rgb2yiq(IDis);

%% Feature extraction
%% DOG
kband = 5;
SR = gsplit_img(IRef,kband);
SD = gsplit_img(IDis,kband);
for i = 1:kband
   X(i) =  PSNR(SR(:,:,i),SD(:,:,i));
end

for i = (1:kband) + 5
   X(i) =  ssim_index(SR(:,:,i-5),SD(:,:,i-5));
end

for i = (1:kband) + 10
   X(i) =  FeatureSIM(SR(:,:,i-10),SD(:,:,i-10));
end
%% color feature
T3 = 200;
T4 = 200;
Is = (2 * IR .* ID + T3) ./ (IR.^2 + ID.^2 + T3);
Qs = (2 * QR .* QD + T4) ./ (QR.^2 + QD.^2 + T4);
X(16) = mean2(Is);
X(17) = mean2(Qs);
X(18) = mean2(Is.*Qs);



