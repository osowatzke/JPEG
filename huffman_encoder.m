% function creates a huffman dictionary and zig-zag encodes a quantized 
% image using the dictionary.
function [encoded_image, dict] = huffman_encoder(imdata) 

    % determine unique quantized values
    unique_vals = unique(imdata);
    
    % empty vector holds the number of occurences
    num_occurences = zeros(size(unique_vals));
    
    % loop determines the num of occurences for each of the unique values
    for k = 1:length(num_occurences)
        num_occurences(k) = sum(imdata == unique_vals(k),'all');
    end
    
    % determine the size of the image
    [H, W] = size(imdata(:,:,1));
    
    % determine the number of pixels
    num_pixels = H*W*3;
    
    % determine the probability of each quantized value occurring
    prob = num_occurences./num_pixels;
    
    % create huffman dictionary
    dict = huffmandict(unique_vals,prob);
    
    % create vector from MxNx3 image
    % vector reshapes image array into 1x(M*N*3) zig-zag encoded vector
    imvector = zig_zag(imdata);
    
    % encode image using huffman dictionary
    encoded_image = huffmanenco(imvector,dict);
end