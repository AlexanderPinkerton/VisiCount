function [ct] = how_many ( prefix, x, ct_f )

% init ctr
ct = zeros ( 1, numel ( ct_f ) );

% for all frames to count
for i = 1:numel(ct_f)
    
    % read image and convert to gray
    fileName = sprintf('%s%05d.png', prefix, ct_f(i));
    input_im = rgb2gray ( imread(fileName) );
%     imshow(input_im);
%     pause();
    
    % compute diff from mean image
    diff_im = uint8(abs(int16 ( input_im ) - int16 ( x.mean_im )));
    
%     imshow(diff_im);
%     pause();
    
    % threshold on some threshold trained
    t = 20;
    t_im = diff_im > t;
    
    imshow(t_im);
    pause();
    
    % divide by some random value 
    ct(i) = ccl(t_im);
%     ct(i) = x.count(i,1);
    
end
