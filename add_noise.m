% function adds noise to its input image array such that the noisy image
% has a given PSNR.

% inputs: 
%   PSNR                Peak Signal to noise ratio
%   input_im_array      MxNx3 uint8 image array

% outputs:
%   noisy_im_array      MxNx3 uint8 image array with additive white noise

function noisy_im_array = add_noise(input_im_array, PSNR)
    
    % if PSNR is Inf do not add noise
    % image passes function untouched
    if isinf(PSNR)
        noisy_im_array = input_im_array;
    else
        % determine MSE corresponding to PSNR
        MSE = 255^2/(10^(PSNR/10));

        % note that the MSE for an RGB image is 
        % the sum of all squared differences / (image_size * 3)
        % for zero mean white noise this is equivalent to the variance of 
        % each noise component.

        % generate array of noise
        noise_array = sqrt(MSE).*randn(size(input_im_array));

        % add noise to image to produce noise image
        noisy_im_array = noise_array + double(input_im_array);

        % convert double to unit8
        noisy_im_array = uint8(noisy_im_array);
    end
    
end