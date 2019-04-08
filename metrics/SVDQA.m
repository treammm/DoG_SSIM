function qs = SVDQA(imageRef,imageDis)

k = 1:20;

if isrgb(imageRef) %images are colorful
    Y1 = 0.299 * double(imageRef(:,:,1)) + 0.587 * double(imageRef(:,:,2)) + 0.114 * double(imageRef(:,:,3));
    Y2 = 0.299 * double(imageDis(:,:,1)) + 0.587 * double(imageDis(:,:,2)) + 0.114 * double(imageDis(:,:,3));
    I1 = 0.596 * double(imageRef(:,:,1)) - 0.274 * double(imageRef(:,:,2)) - 0.322 * double(imageRef(:,:,3));
    I2 = 0.596 * double(imageDis(:,:,1)) - 0.274 * double(imageDis(:,:,2)) - 0.322 * double(imageDis(:,:,3));
    Q1 = 0.211 * double(imageRef(:,:,1)) - 0.523 * double(imageRef(:,:,2)) + 0.312 * double(imageRef(:,:,3));
    Q2 = 0.211 * double(imageDis(:,:,1)) - 0.523 * double(imageDis(:,:,2)) + 0.312 * double(imageDis(:,:,3));
else %images are grayscale
    Y1 = double(imageRef);
    Y2 = double(imageDis);
end


[U,S,V] = svd(Y1);
[Up,Sp,Vp] = svd(Y2);
a = diag(U'*Up);
b = diag(V'*Vp);
sa = diag(S);
sb = diag(Sp);
ss = (sa(1:k)-sb(1:k)).^2;
% x = ss(k)*(a(1:k)+b(1:k));
% x = x*k/sum(ss);
x = a(k)+b(k);
%qs = norm(x,2);
qs = [x ; ss]';

end
% O = Up(:,1:k)*Vp(:,1:k)';
% OC = zeros(size(A));
% OC(:,:,1) = O(:,1:h);
% OC(:,:,2) = O(:,h+1:2*h);
% OC(:,:,3) = O(:,2*h+1:3*h);
% OC = imadjust(OC,[],[],0.4);
% imshow(OC)
% imwrite(OC,'op1.jpg','jpg');