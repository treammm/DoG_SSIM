function y = huediff(IR,ID)
HR = rgb2hsv(IR);
HD = rgb2hsv(ID);
y = corr2(HR(:,:,1),HD(:,:,1));

