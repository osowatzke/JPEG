% function takes the encoded_image (binary vector) and huffman dictionary
% and performs huffman decoding. The image size argument is used to form 
% the quantized image from an image vector.

% inputs:
%   encoded_image       1xN vector of binary values
%   huffman_dict        Huffman dictionary used for encoding and decoding 
%   image_size          1x3 vector containing size of original image

% outputs
%   quant_array         MxNx3 array of quantized values

function quant_array = huffman_decoder(encoded_image, huffman_dict, image_size)
    
    % decode huffman image vector
    imvector = huffmandeco(encoded_image,huffman_dict);
    
    % run length decoding on image vector
    imvector = run_length_decoding(imvector);
    
    % determine size of quantized image 
    % ensure rows and columns are multiples of 8
    quant_size = image_size;
    for k = 1:2
        if mod(quant_size(k),8) ~= 0
            quant_size(k) = quant_size(k) + (8-mod(quant_size(k),8));
        end
    end
    
    % form MxNx3 array of quantized values from image vector
    quant_array = reform(imvector,quant_size);
    
end