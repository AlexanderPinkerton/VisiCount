image = imread('data/intersection/images/intersection_01291.png');
% image = imread('data/ant/images/ant_00009.png');

background = load('intersectionBackground.mat');
% background = load('antBackground.mat');
gray_im = rgb2gray(image);
bgimage = background.x.mean_im;
diff_im = uint8(abs(int16 ( gray_im ) - int16 ( bgimage )));

% k = 0.70;
% while count ~= 50
    thresh = adaptiveThresh(gray_im, diff_im, .15, 5);
    count = ccl(thresh, 125);
    imshow(thresh);
    disp(count);
%     k = k + .01;
% end



% imshow(bgimage);
% pause();
% imshow(gray_im);
% pause();
% imshow(diff_im);
% pause();
% imshow(thresh);
% pause();

