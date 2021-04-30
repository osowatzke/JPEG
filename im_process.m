
% function takes PSNR and relative input path of image as an inputs
function [original_size, compressed_size, mse, im_result, diff] = ...
    im_process(image_path, PSNR, qf)
    
    % read RGB components of images and format in MXNX3 array
    original_image = imread(image_path);
    
    % determine image size
    [H, W, RGB] = size(original_image);
    original_size = H*W*RGB;
    
    % add noise to image
    noisy_image = add_noise(original_image,PSNR);
    
    % display noisy image
    %figure
    %imshow(noisy_image);
    
    % convert to YCbCr colorspace
    ycbcr_image = rgb2ycbcr(noisy_image);
    
    % functions returns DCT of 8x8 blocks of image
    % formatted as MxNx3 double array
    dct_image = fwd_DCT(ycbcr_image);
    
    % determine quantized image data
    % formatted as MxNx3 integer array
    quant_image = quantizer(dct_image, qf);
    
    % create huffman dictionary and encode quantized image
    [encoded_image, dict] = huffman_encoder(quant_image);
    
    % determine compressed size
    compressed_size = ceil(length(encoded_image)/8);
    
    % output encoded image size
    fprintf("Encoded Image Size: %d Bytes\n", compressed_size);
    
    % decode image using huffman dictionary
    % image vector is reformed into MxNx3 integer array when decoding
    decoded_image = huffman_decoder(encoded_image, dict, size(quant_image));
    
    % dequantize quantized image data
    % also formatted as MxNx3 integer array
    dequant_image = dequantizer(decoded_image,qf); %quant_image
    
    % perform IDCT on 8x8 blocks of image
    % returns MxNx3 uint8 array (same size as original image)
    [r, c] = size(original_image(:,:,1));
    idct_image = rev_IDCT(r,c,dequant_image);
    
    % determine resulting image YCbCr
    ycbcr_image = idct_image(1:length(original_image(:,1,1)), ...
        1:length(original_image(1,:,1)), :);
    
    % determine image results
    im_result = ycbcr2rgb(ycbcr_image);
    
    % compute mse between 2 images 
    mse = compute_mse(original_image, im_result);
    % display MSE value
    fprintf('MSE = %.3f \n',mse);
    
    % display difference image of 2 images
    diff = diff_img(original_image,noisy_image);
    
    % display reconstructed image
    %figure
    %imshow(im_result);
    
end