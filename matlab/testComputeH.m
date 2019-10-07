%% Convert images to grayscale, if necessary
clear;
datadir     = '../data';
img1 = imread(sprintf('%s/%s', datadir, 'cv_cover.jpg'));
img2 = imread(sprintf('%s/%s', datadir, 'cv_desk.png'));

[x1, x2] = matchPics(img1, img2);

%H2to1 = computeH_norm(x1,x2);
%H2to1 = computeH(x1,x2);
[H2to1, inliers] = computeH_ransac(x1,x2);
locs1 = x1(inliers, :);
borders = [0 0; 350 0; 0 440; 350 440; 330 420; 20 20];
%locs1 = borders;

locs1 = cart2hom(locs1);

%locs1 = [14 7 1; 350 66 1; 50 298 1; 185 98 1; 289 378 1; 225 225 1];  % test locations

locs2 = H2to1*locs1';

% convert back to cartesian coordinates
locs2 = hom2cart(locs2');
locs1 = hom2cart(locs1);


showMatchedFeatures(img1,img2,locs1,locs2, 'montage');


