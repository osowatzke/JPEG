% function performs adds noise to image (if desired) and performs image
% compression/decompression

% inputs:
%   input_im_array          MxNx3 uint8 array of RGB pixel values
%   PSNR                    PSNR ratio to be created by add_noise function 
%                           (set to Inf if noise is not desired)
%   qf                      quality factor for quantization

% outputs:
%   bytes_orig              number of bytes in uncompressed image
%   bytes_compressed        number of bytes in compressed image
%   mse                     MSE after compression/decompression
%   noisy_im_array          image with additive white noise
%   out_im_array            decompressed image
%   diff                    difference image between input_im_array and 
%                           out_im_array

function [bytes_orig, bytes_compressed, mse, noisy_im_array, ...
    out_im_array, diff] = im_process(input_im_array, PSNR, qf)
    
    % get statistics of input image size and size in bytes
    [image_size, bytes_orig] = input_image_stats(input_im_array);
    
    % add noise to image
    noisy_im_array = add_noise(input_im_array,PSNR);
    
    % perform image compression
    [encoded_image, huffman_dict, bytes_compressed] = ...
    compress_image(noisy_im_array, qf);

    % peform image decompression
    out_im_array = decompress_image(image_size, encoded_image, ...
    huffman_dict, qf);
    
    % get performance metrics for image compression/decompression
    [diff, mse] = get_performance(out_im_array, input_im_array);
    
end