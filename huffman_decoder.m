% function takes the encoded_image (binary vector) and huffman dictionary
% and performs huffman decoding. The image size argument is used to form 
% the quantized image from an image vector.
function decoded_image = huffman_decoder(encoded_image, dict, image_size)
    
    % decode huffman image vector
    imvector = huffmandeco(encoded_image,dict);
   
    % form MxNx3 image from image vector
    decoded_image = reform(imvector,image_size);
end