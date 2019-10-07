% Q3.3.1
clear;
book = loadVid('../data/book.mov');
source = loadVid('../data/ar_source.mov');
cv_img = imread('../data/cv_cover.jpg');
output = VideoWriter('../results/movie.avi');
open(output);

nFrames = length(source);

% scale down book img
[h,w] = size(cv_img);
[movie_h, movie_w, ~] = size(source(1).cdata);
scale = movie_h / h;
cv_img = imresize(cv_img, scale);

%amount to crop on each side
crop = (movie_w - w) / 2;

for i = 1:nFrames
    [locs1, locs2] = matchPics(cv_img, book(i).cdata);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    scaled_movie_img = source(i).cdata(:, crop:movie_w-crop,:);
    ar_img = compositeH(inv(bestH2to1), scaled_movie_img, book(i).cdata);
    writeVideo(output, ar_img);
end

close(output);
