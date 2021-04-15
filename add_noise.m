% function takes a MxNx3 image array and PSNR as inputs
% and returns the image array + noise
function noisy_imarray = add_noise(imarray, PSNR)

    % determine MSE corresponding to PSNR
    MSE = 255^2/(10^(PSNR/10));
    
    % note that the MSE for an RGB image is 
    % the sum of all squared differences / (image_size * 3)
    % for zero mean white noise this is equivalent to the variance of each
    % noise component.
    
    % generate array of noise
    noise_array = sqrt(MSE).*randn(size(imarray));
    
    % add noise to image to produce noise image
    noisy_imarray = noise_array + double(imarray);
    
end