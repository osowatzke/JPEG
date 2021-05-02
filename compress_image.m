% function is responsible for image compression

% inputs:
%   in_rgb_array        input rgb array MxNx3 uint8 array
%   qf                  quality factor (integer from 1 to 100)

% outputs:
%   encoded_image       1xN vector containing 1's and 0's
%   huffman_dict        Dictionary used to encode/decode image
%   compressed_size     Number of bytes in compressed image

function [encoded_image, huffman_dict, compressed_size] = ...
    compress_image(in_rgb_array, qf)

    % convert image from RGB color space to YCbCr color space
    ycbcr_array = rgb2ycbcr(in_rgb_array);
    
    % take the dct2 of the input image in 8x8 blocks
    dct_array = fwd_DCT(ycbcr_array);
    
    % quantize array of DCT values in 8x8 blocks using quantization factor
    % and quantization table
    quant_array = quantizer(dct_array, qf);
    
    % perform huffman encoded of the image in 8x8 blocks
    [encoded_image, huffman_dict, compressed_size] = ...
        huffman_encoder(quant_array);
    
end