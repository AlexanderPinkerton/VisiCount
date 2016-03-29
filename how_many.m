function [ct] = how_many ( prefix, x, ct_f )

% init ctr
ct = zeros ( 1, numel ( ct_f ) );

% for all frames to count
for i = 1:numel(ct_f)
    
    % read image and convert to gray
    fileName = sprintf('%s%05d.png', prefix, ct_f(i));
    gray_im = rgb2gray ( imread(fileName) );
    
    bgimage = x.mean_im;
%     gray_im = rgb2gray(input_im);

    %compute diff from mean image
    diff_im = uint8(abs(int16 ( gray_im ) - int16 ( bgimage )));

%     thresh = adaptiveThresh(gray_im, diff_im, 0.9, 5);
    thresh = adaptiveThresh(gray_im, diff_im, x.k, x.kernel);
    
%     imshow(thresh);
%     pause();
    
    count = ccl(thresh, x.min);
%     disp(count);
    ct(i) = count;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
% %     imshow(input_im);
% %     pause();
%     
%     % compute diff from mean image
%     diff_im = uint8(abs(int16 ( input_im ) - int16 ( x.mean_im )));
%     
% %     imshow(diff_im);
% %     pause();
%     
%     % threshold on some threshold trained
%     t = 20;
%     t_im = diff_im > t;
%     
%     imshow(t_im);
%     pause();
%     
%     % divide by some random value 
   

    
end
