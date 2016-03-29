function [ thresh ] = adaptiveThresh( gray_im, diff_im, sensitivity, kernelSize )
%ADAPTIVETHRESH Summary of this function goes here
%Convolve with mean kernel for threshold values===================
filtered = zeros(size(gray_im));
k=fix(kernelSize/2);
padded = padarray(gray_im,[k k]);
kernel = 1/kernelSize * ones(1,kernelSize);
kernel = kernel' * kernel;
for i = 1:1:size(gray_im,1)
        for j = 1:1:size(gray_im,2)
            filtered(i,j) = sum(sum(double(padded(i:i+kernelSize-1,j:j+kernelSize-1)) .* (sensitivity * kernel)));
        end
end
% imshow(uint8(filtered));
% pause();
%==================================================================
thresh = zeros(size(gray_im));
for i = 1:1:size(filtered,1)
        for j = 1:1:size(filtered,2)
            if diff_im(i,j) > filtered(i,j)
                thresh(i,j) = 1;
            else
                thresh(i,j) = 0;
            end
        end
end