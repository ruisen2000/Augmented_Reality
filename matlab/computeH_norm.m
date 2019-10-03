function [H2to1] = computeH_norm(x1, x2)
scatter(x1(:,1),x1(:,2))
figure
scatter(x2(:,1),x2(:,2))
figure
%% Compute centroids of the points
centroid1 = [mean(x1(:,1)), mean(x1(:,2))];
centroid2 = [mean(x2(:,1)), mean(x2(:,2))];

%% Shift the origin of the points to the centroid
x1(:,1) = x1(:,1) - centroid1(1);
x1(:,2) = x1(:,2) - centroid1(2);
x2(:,1) = x2(:,1) - centroid2(1);
x2(:,2) = x2(:,2) - centroid2(2);

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
avg_dist1 = mean(hypot(x1(:, 1), x1(:,2)));  % avg distance from origin of x1
avg_dist2 = mean(hypot(x2(:, 1), x2(:,2)));
scale1 = avg_dist1 / sqrt(2);
scale2 = avg_dist2 / sqrt(2);
%% similarity transform 1
T1 = diag([1/scale1,1/scale1,1]);  % convert to homogeneous coordinates to do the transformation
x1 = cart2hom(x1)'; % need to convert each coordinate to column vector for matrix multiplication
x1 = T1*x1;
x1 = hom2cart(x1');
scatter(x1(:,1),x1(:,2))
figure
%avg_dist1 = mean(hypot(x1(:, 1), x1(:,2)))
%% similarity transform 2
T2 = diag([1/scale2,1/scale2,1]);
x2 = cart2hom(x2)';
x2 = T2*x2;
x2 = hom2cart(x2');
scatter(x2(:,1),x2(:,2))
figure
%avg_dist2 = mean(hypot(x2(:, 1), x2(:,2)))
%% Compute Homography
H2to1 = computeH(x1,x2);

%% Denormalization
H2to1 = inv(T1)*H2to1*T2;
