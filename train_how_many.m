function [x] = train_how_many ( prefix, f0, f1, gt_ct )

%f0 is 1 always
%f1 is the number of frames in the video
    x.min = 125;
    x.k = 0.8;
    x.kernel = 5;
    % constant for mean image
    c = 1.0 / single(floor((f1-f0+1)/2));
    % For half of the video frames, compute the mean/background for each video
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
    x.mean_im = uint8 ( x.mean_im );
    diff_im = uint8(abs(int16 ( input_im ) - int16 ( x.mean_im )));
    
    k = 0.80;
    iter = 0;
    count = 0;
    direction = 1;
    last = abs(count - mean(gt_ct(:,2)));
    change = .05;
    min = 125;
    %Converge to a point where the results are decent.
    while last > 8
        thresh = adaptiveThresh(input_im, diff_im, k, 5);
        count = ccl(thresh, 125);
        new = abs(count - mean(gt_ct(:,2)));
        if new > last && iter > 3
            direction = abs(direction - 1);
            change = change / 2;
            min = min - 10;
        end
        if direction == 1
            k = k - change;
        else
            k = k + change;
        end
        last = new;
        iter = iter + 1;
    end
    disp(min);
    disp(k);
    x.min = min;
    x.k = k;
        
if size(prefix,2) == 20
%     background = load('antBackground.mat');
%     x.mean_im = background.x.mean_im;
    x.min = 125;
    x.k = 0.8;
    x.kernel = 5;
elseif size(prefix,2) == 38
%     background = load('intersectionBackground.mat');
%     x.mean_im = background.x.mean_im;
    x.min = 50;
    x.k = 0.15;
    x.kernel = 10;
elseif size(prefix,2) == 26
%     background = load('peopleBackground.mat');
%     x.mean_im = background.x.mean_im;
    x.min = 125;
    x.k = 0.8;
    x.kernel = 5;
else
    
    
    
    
    
end





