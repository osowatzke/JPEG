% function creates a huffman dictionary and zig-zag encodes a quantized 
% image using the dictionary.

% inputs:
%   quant_array         MxNx3 array of quantized dct values

% outputs:
%   encoded_image       1xN vector containing 1's and 0's
%   huffman_dict        Dictionary used to encode/decode image
%   compressed_size     Number of bytes in compressed image

function [encoded_image, huffman_dict, compressed_size] = huffman_encoder(quant_array) 

    % determine unique quantized values
    unique_vals = unique(quant_array);
    
    % empty vector holds the number of occurences
    num_occurences = zeros(size(unique_vals));
    
    % loop determines the num of occurences for each of the unique values
    for k = 1:length(num_occurences)
        num_occurences(k) = sum(quant_array == unique_vals(k),'all');
    end
    
    % determine the size of the image
    [H, W] = size(quant_array(:,:,1));
    
    % determine the number of pixels
    num_pixels = H*W*3;
    
    % determine the probability of each quantized value occurring
    prob = num_occurences./num_pixels;
    
    % create huffman dictionary
    huffman_dict = huffmandict(unique_vals,prob);
    
    % create vector from MxNx3 image
    % vector reshapes image array into 1x(M*N*3) zig-zag encoded vector
    imvector = zig_zag(quant_array);
    
    % encode image using huffman dictionary
    encoded_image = huffmanenco(imvector,huffman_dict);
    
    % determine number of bytes in encoded image
    % division by 8 to convert from bits to bytes
    compressed_size = ceil(length(encoded_image)/8);
    
end