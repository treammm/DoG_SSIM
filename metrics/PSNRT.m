function psnr_Value = PSNR(A,B,S)
% PSNR (Peak Signal to noise ratio)
% S = ones(size(A,1),size(A,2));
if (size(A) ~= size(B))
   error('The size of the 2 matrix are unequal')

   psnr_Value = NaN;
   return; 
elseif (A == B)
   disp('Images are identical: PSNR has infinite value')

   psnr_Value = Inf;
   return;   
else

    maxValue = double(max(A(:)));
    S = S.^0.5;
    % Calculate MSE, mean square error.
    mseImage = ((double(A) - double(B)) .^ 2).*S;
%     wmse = mseImage./Weight;
    [rows columns] = size(A);
%     mse = sum(wmse(:))/sum(mseImage(:));
    mse = sum(mseImage(:)) / (rows * columns)/sum(S(:));

    % Calculate PSNR (Peak Signal to noise ratio)
    psnr_Value = 10 * log10( 256^2 / mse);
end