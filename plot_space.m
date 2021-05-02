% function only takes in qf_array of size 9 to produce 3x3 subplot as of
% now

function plot_space(image_path, PSNR, qf_array)

% get MxNx3 array of data from image
input_im_array = imread(image_path);
    
qf = 0;  % Q doesn't matter here, doesn't affect the output we want
[original_size,~,~,noisy_image,~,~] = im_process(input_im_array,PSNR,qf);

% show minimal noise image 
figure;
imshow(noisy_image);
title(['Original Image (Size: ',num2str(original_size),' Bytes)']);

% show images with corresponding byte size after running thru system 
% with different Q values
figure;
for ii = 1:length(qf_array)

    % quality factor
    qf = qf_array(ii);
    
    % process image for various PSNR values 
    [~, compressed_size, ~, ~, im_result, ~] = ...
    im_process(input_im_array, PSNR, qf);
    
%     drawnow;
    subplot(3,3,ii);
    imshow(im_result);
    title(['Q = ',num2str(qf)])
    xlabel(['Compressed Size = ',num2str(compressed_size),' Bytes']);
    xh = get(gca,'xlabel'); % handle to the label object
    p = get(xh,'position'); % get the current position property
    p(2) = 0.9*p(2);        % double the distance, 
                           % negative values put the label below the axis
    set(xh,'position',p); 
end
end