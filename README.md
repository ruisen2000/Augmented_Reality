Assignment 2: Augmented Reality Movie Player

See results/movie_t1 for final results. 
The movie is overlayed onto a book, and stays on top of the book even as the camera moves around and the book changes orientation.
This is done using the BRIEF feature detector to get point pairs and find the position of the book.  Every frame, a homography matrix is computed to find the orientation 
of the book, so that the video can be warped to that orientation and mapped onto the book cover.   The RANSAC algorithm is used to speed up the computation of the homography matrix.
