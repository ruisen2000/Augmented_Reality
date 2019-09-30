% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
datadir     = '../data';
img1 = imread(sprintf('%s/%s', datadir, 'cv_cover.jpg'));

if (ndims(img1) == 3)
        img1 = rgb2gray(I1);
end
%% Compute the features and descriptors
numFeatures = zeros(1,35);
numFeatures_surf = zeros(1,35);
for i = 1:35
    %% Rotate image
    rotated_img = imrotate(img1, 10*i);
    %% Compute features and descriptors
    p1 = detectFASTFeatures(img1);
    p2 = detectFASTFeatures(rotated_img);
    p3 = detectSURFFeatures(img1);
    p4 = detectSURFFeatures (rotated_img);
    
    [desc1, locs1] = computeBrief(img1, p1.Location);
    [desc2, locs2] = computeBrief(rotated_img, p2.Location);
    
    [desc3, locs3] = computeBrief(img1, p3.Location);
    [desc4, locs4] = computeBrief(rotated_img, p4.Location);
    %% Match features
    indexPairs = matchFeatures(desc1,desc2, 'MatchThreshold', 10, 'MaxRatio', 0.7);  
    indexPairs_surf = matchFeatures(desc3,desc4, 'MatchThreshold', 10, 'MaxRatio', 0.7);    
    %% Update histogram
    [r,c] = size(indexPairs);
    [r_s,c_s] = size(indexPairs_surf);
    numFeatures(i) = r;
    numFeatures_surf(i) = r_s;
end

%% Display histogram
histogram(numFeatures);
figure;
histogram(numFeatures_surf);