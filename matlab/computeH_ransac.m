function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
    %COMPUTEH_RANSAC A method to compute the best fitting homography given a
    %list of matching points.
    N = 50000; % number of iterations
    threshold = 15;
    max_inliers = 0;
    bestH2to1 = zeros(3,3);

    for i = 1:N
        [x1, indx] = datasample(locs1,5);  % choose 4 random points from locs1
        x2 = locs2(indx, :);
        H = computeH_norm(x1,x2);
        
        % find out how good this H matrix is
        sample = H*(cart2hom(locs1)');
        sample = hom2cart(sample');
        distance = sqrt(sum((sample - locs2) .^ 2, 2));   % get distance between computed point and actual point
        %mean(distance)
        num_inliers = sum(distance < threshold);
        
        if num_inliers > max_inliers
            num_inliers
            max_inliers = num_inliers;
            bestH2to1 = H;
            inliers = distance < threshold;
        end            
    end
end

