% function determines performance metrics of compression/decompression
% process

% inputs:
%   out_im_array            output of decompression function MxNx3 array
%   input_im_array          input image in MxNx3 array

% outputs:
%   diff                    difference image
%   mse                     mean squared error

function [diff, mse] = get_performance(out_im_array, input_im_array)
    
    % note that the input_im_array does not contain noise so we can 
    % determine denoising metrics for the compression/decompression
    % process
    
    % determine difference image
    diff = imabsdiff(out_im_array, input_im_array);
    
    % determine mse error in compression/decompression process
    mse = immse(out_im_array, input_im_array);
    
end