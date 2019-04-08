clear all
toolboxAdd
%% reference image cell
refDir='../reference_images/';
fprintf('Collecting reference image from "%s"...\n', refDir);
refData=recursiveFileList(refDir, 'bmp');	% Collect all wave files
for i = 1:length(refData)
    Ref{i}=imread(['../reference_images/' refData(i).name]);
end

refData=recursiveFileList('../saliency/', 'png');	
for i = 1:length(refData)
    sali{i}=imread(['../saliency/' refData(i).name]);
end
%% distorted image extract
load name.mat
% disDir='../distorted_images/';
% fprintf('Collecting distortion image from "%s"...\n', disDir);
% disData=recursiveFileList(disDir, 'bmp');	% Collect all wave files
%% IQA
n = length(name);
load ../mos.txt;
objs = zeros(n,1);
for i = 1:n
D = imread(['../distorted_images/' name{i}]);
index = str2num(name{i}(2:3));
% S = im2double(sali{index});
% X(i,:) = featurev1(Ref{index},D,S);
X(i,:) = featurev1(Ref{index},D);

end
%% normalize the I/P
trndata.X = X(:,[1:5 18]);
trndata.y = mos;
% [trndata,~,~]=scale(trndata,trndata,trndata,0,1);

%% cross-validatuin indicate
k = 20;
ind = ones(1,n/k)'*(1:k);
ind = ind(:);
xobj = zeros(1,n);
ymos = zeros(1,n);
for i = 1:k
trnidx = find(ind~=i);
tstidx = find(ind==i);
% model = svmtrain(trndata.y(trnidx,:),trndata.X(trnidx,:), '-s 4 -t 2 -c 20 -g 64 -p 1');
% [y_hat, Acc,projection] = svmpredict(trndata.y(tstidx,:),trndata.X(tstidx,:), model);
model = regRF_train(trndata.X(trnidx,:),trndata.y(trnidx,:));
y_hat = regRF_predict(trndata.X(tstidx,:),model);

xobj(tstidx) = y_hat;
ymos(tstidx) = trndata.y(tstidx,:);
% xobj = [xobj ; y_hat];
% ymos = [ymos ; trndata.y(tstidx,:)];
end
xobj(isnan(xobj)) = [];
ymos(isnan(xobj)) = [];
%write file

%fid = fopen('../metrics_values/RRR.txt', 'wb');
%fprintf(fid, '%.4f\n', xobj);
%fclose(fid); 
% rank correlation coefficient

[RS,~] = corr(xobj', ymos','Type','Spearman');
[RK,~] = corr(xobj', ymos','Type','Kendall');
%% logistic regression
%plot objective-subjective score pairs
p = plot(xobj',ymos','+');
set(p,'Color','blue','LineWidth',1);

%initialize the parameters used by the nonlinear fitting function
beta(1) = 1;
beta(2) = 0;
beta(3) = mean(xobj);
beta(4) = 0.1;
beta(5) = 0.1;
%fitting a curve using the data
[bayta ehat,J] = nlinfit(xobj',ymos',@logistic,beta);
%given an objective value, predict the correspoing mos (ypre) using the fitted curve
[ypre junk] = nlpredci(@logistic,xobj',bayta,ehat,J);

RMSE = sqrt(sum((ypre - ymos').^2) / length(ymos'));%root meas squared error
RP = corr(ymos', ypre, 'type','Pearson') %pearson linear coefficient

%draw the fitted curve
t = min(xobj):0.01:max(xobj);
[ypre junk] = nlpredci(@logistic,t,bayta,ehat,J);
hold on;
p = plot(t,ypre);
set(p,'Color','black','LineWidth',2);
legend('Images in TID2013','Curve fitted with logistic function', 'Location','NorthWest');
xlabel('\bfPSNR-DOG ','Fontsize',14);
ylabel('\bfMOS','Fontsize',14);