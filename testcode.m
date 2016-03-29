image = imread('data/intersection/images/intersection_01291 .png');
% image = imread('data/ant/images/ant_00009.png');

background = load('intersectionBackground.mat');
% background = load('antBackground.mat');

bgimage = background.x.mean_im;
gray_im = rgb2gray(image);

%compute diff from mean image
diff_im = uint8(abs(int16 ( gray_im ) - int16 ( bgimage )));

thresh = adaptiveThresh(gray_im, diff_im, 0.05, 5);

imshow(thresh);
pause();

count = ccl(thresh, 50);
disp(count);



% imshow(bgimage);
% pause();
% imshow(gray_im);
% pause();
% imshow(diff_im);
% pause();
% imshow(thresh);
% pause();

