
% function takes PSNR and relative input path of image as an inputs
function top_level(image_path, PSNR, qf)
    
    % read RGB components of images and format in MXNX3 array
    original_image = imread(image_path);
    
    % add noise to image
    noisy_image = add_noise(original_image,PSNR);
    
    % display noisy image
    imshow(noisy_image);
    
    % functions returns DCT of 8x8 blocks of image
    % formatted as MxNx3 double array
    dct_image = fwd_DCT(noisy_image);
    
    % determine quantized image data
    % formatted as MxNx3 integer array
    quant_image = quantizer(dct_image, qf);
    
    % create huffman dictionary based on quantized image data
    huff_dict = create_huffman_dict(quant_image);
        
    % dequantize quantized image data
    % also formatted as MxNx3 integer array
    dequant_image = dequantizer(quant_image,qf);
    
    % perform IDCT on 8x8 blocks of image
    % returns MxNx3 uint8 array (same size as original image)
    [r, c] = size(original_image(:,:,1));
    idct_image = rev_IDCT(r,c,dct_image);
    
    % compute mse between 2 images 
    mse = compute_mse(original_image, noisy_image);
    % display MSE value
    fprintf('MSE = %.3f \n',mse);
    
    % display difference image of 2 images
    diff_img(original_image,noisy_image);
    
end