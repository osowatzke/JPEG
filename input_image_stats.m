% function determines statistics of input image (size in pixels, num of
% bytes)

% inputs: 
%   input_im_array      MxNx3 uint8 image array

% outputs:
%   image_size          1x3 array containing the image size
%   bytes_orig          Number of bytes in input image

function [image_size, bytes_orig] = input_image_stats(input_im_array)
    
    % determine size of input image
    % should be [M, N, 3] for MxNx3 image
    image_size = size(input_im_array);
    
    % determine bytes in input image
    % note that each pixel contains 3 bytes
    bytes_orig = image_size(1)*image_size(2)*3;
    
end