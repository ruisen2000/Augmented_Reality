function [H2to1] = computeH_norm(x1, x2)
%scatter(x1(:,1),x1(:,2))
%figure
%scatter(x2(:,1),x2(:,2))
%figure
%% Compute centroids of the points
centroid1 = [mean(x1(:,1)), mean(x1(:,2))];
centroid2 = [mean(x2(:,1)), mean(x2(:,2))];

%% Shift the origin of the points to the centroid
shiftMatrix1 = [1 0 -centroid1(1); 0 1 -centroid1(2); 0 0 1];
shiftMatrix2 = [1 0 -centroid2(1); 0 1 -centroid2(2); 0 0 1];

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
avg_dist1 = mean(hypot(x1(:, 1), x1(:,2)));  % avg distance from origin of x1
avg_dist2 = mean(hypot(x2(:, 1), x2(:,2)));
scale1 = avg_dist1 / sqrt(2);
scale2 = avg_dist2 / sqrt(2);
%% similarity transform 1
T1 = diag([1/scale1,1/scale1,1]);  % convert to homogeneous coordinates to do the transformation
x1 = cart2hom(x1)'; % convert each coordinate to column vector for matrix multiplication since row 1, col 1 of result = row 1 of A * col 1 of x1
transform1 = T1 * shiftMatrix1;  % combine the 2 transformations into a single matrix

x1 = transform1*x1;
x1 = hom2cart(x1');

%% similarity transform 2
T2 = diag([1/scale2,1/scale2,1]);
x2 = cart2hom(x2)';
transform2 = T2 * shiftMatrix2;
x2 = transform2*x2;
x2 = hom2cart(x2');


%% Compute Homography
H2to1 = computeH(x1,x2);

%% Denormalization
H2to1 = inv(transform2)*H2to1*transform1;
