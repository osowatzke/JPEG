% function takes PSNR and relative input path of image as an inputs
function top_level(image_path, PSNR)
    
    % read RGB components of images and format in MXNX3 array
    original_image = imread(image_path);
    
    % add noise to image
    noisy_image = add_noise(original_image,PSNR);
    
    % display image
    imshow(noisy_image);
end