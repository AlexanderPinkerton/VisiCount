function [x] = train_how_many ( prefix, f0, f1, gt_ct )

%f0 is 1 always
%f1 is the number of frames in the video

% constant for mean image
c = 1.0 / single(floor((f1-f0+1)/2));


%For half of the video frames, compute the mean/background for each video
for i = f0:2:f1

    % read image and convert to gray
    fileName = sprintf('%s%05d.png', prefix, i );
    input_im = rgb2gray ( imread(fileName) );
    
    
    % update mean image
    if ( i == f0 )
        x.mean_im = c * single(input_im);
    else
        x.mean_im = x.mean_im + c * single(input_im);
    end
    
end


% The mean image is the estimated background for the frame.
% convert to uint8 for future usage
testbackground = uint8 ( x.mean_im );
x.mean_im = uint8 ( x.mean_im );
x.count = gt_ct;

