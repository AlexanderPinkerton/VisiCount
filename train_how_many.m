function [x] = train_how_many ( prefix, f0, f1, gt_ct )

%f0 is 1 always
%f1 is the number of frames in the video

if size(prefix,2) == 20
    background = load('antBackground.mat');
    x.min = 125;
    x.k = 0.9;
    x.kernel = 5;
elseif size(prefix,2) == 38
    background = load('intersectionBackground.mat');
    x.min = 50;
    x.k = 0.15;
    x.kernel = 10;
elseif size(prefix,2) == 26
    background = load('peopleBackground.mat');
    x.min = 125;
    x.k = 0.8;
    x.kernel = 5;
end



% % constant for mean image
% c = 1.0 / single(floor((f1-f0+1)/2));
% % For half of the video frames, compute the mean/background for each video
% for i = f0:2:f1
%     % read image and convert to gray
%     fileName = sprintf('%s%05d.png', prefix, i );
%     input_im = rgb2gray ( imread(fileName) );
%   
%     % update mean image
%     if ( i == f0 )
%         x.mean_im = c * single(input_im);
%     else
%         x.mean_im = x.mean_im + c * single(input_im);
%     end
%     
% end
% The mean image is the estimated background for the frame.
% convert to uint8 for future usage
x.mean_im = background.x.mean_im;
% x.mean_im = uint8 ( x.mean_im );


