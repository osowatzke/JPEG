
% function takes PSNR and relative input path of image as an inputs
function top_level(image_path, PSNR)
    
    % read RGB components of images and format in MXNX3 array
    original_image = imread(image_path);
    
    % add noise to image
    noisy_image = add_noise(original_image,PSNR);
    
    % convert noisy image from double to uint8
    noisy_image = uint8(noisy_image);
    
    % display noisy image
    imshow(noisy_image);
    
    % compute mse
    compute_mse(original_image, noisy_image);
    
    % display difference image
    diff_img(original_image,noisy_image);
    
end