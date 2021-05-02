% function is responsible for image decompression

% inputs:
%   image_size          1x3 vector containing size of original image
%   encoded_image       1xN vector of huffman encoded bits
%   huffman_dict        Huffman dictionary used for encoding and decoding 
%   qf                  Quality factor used to scale quantization table

% outputs:
%   out_rgb_array       MxNx3 array of RGB values (reconstructed image)

function out_rgb_array = decompress_image(image_size, encoded_image, ...
    huffman_dict, qf)
    
    % function performs huffman decoding on encoded image data
    % result is quantized image data
    quant_array = huffman_decoder(encoded_image,huffman_dict,image_size);
    
    % dequantize values to obtain MxNx3 dct values
    dct_array = dequantizer(quant_array, qf);
    
    % take the idct2 on the dequantized values
    % note that the image must also be resized in this function to account
    % for any padding that we did while taking in the fwd_DCT function
    ycbcr_array = rev_IDCT(dct_array,image_size);
    
    % convert from YCbCr colorspace to RGB colorspace
    out_rgb_array = ycbcr2rgb(ycbcr_array);
    
end