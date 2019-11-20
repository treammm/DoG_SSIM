# Image quality assessment using human visual DOG model fused with random forest
This code is a Matlab implementation of the feature extraction part in [1]. The function for extracting features from an image pair is "featurev1.m". To be more specific, the output X(6:10) is the luminance features for DOG-SSIM and X(18) is the chrominance feature.
You can train the DOG-SSIMc regression model with the feature set X([6:10, 18]), the Random Forest Regressor that I used can be found in [2] [LINK](https://code.google.com/archive/p/randomforest-matlab/downloads).

# References
[1] S. C. Pei and L. H. Chen. Image quality assessment using human visual DOG model fused with random forest. IEEE Trans. Image Process., 24(11):3282–3292, 2015.<br/>
[2] A. Jaiantilal, Classification and Regression by Random Forest-MATLAB, 2009, [online] Available: https://code.google.com/p/randomforest-matlab/issues/detail?id=9&q=citation.

# Bibtex
@article{DOGSSIM2015,
  doi = {10.1109/tip.2015.2440172},
  year = {2015},
  month = nov,
  volume = {24},
  number = {11},
  pages = {3282--3292},
  author = {Soo-Chang Pei and  Li-Heng Chen},
  title = {Image Quality Assessment Using Human Visual {DOG} Model Fused With Random Forest},
  journal = {{IEEE} Transactions on Image Processing}
}
