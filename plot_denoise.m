% only takes in qf_array of length 9 right now to produce 3x3 subplot

function plot_denoise(image_path,PSNR,qf_array)

    % get MxNx3 array of data from image
    input_im_array = imread(image_path);
    
    qf = 50; % arbitrary value to return noisy img, noisy img unaffected by Q
    [~,~,~, noisy_image, ~, ~] = ...
    im_process(input_im_array, PSNR, qf);

    % display noisy image
    figure;
    imshow(noisy_image);
    title('Noisy Image with PSNR = 10');

    % display decompressed image for various Q values
    figure;
    for ii = 1:length(qf_array)

        % quality factor
        qf = qf_array(ii);

        % process image for various PSNR values 
        [~, ~, ~, ~, im_result, ~] = ...
        im_process(input_im_array, PSNR, qf);

        subplot(3,3,ii);
        imshow(im_result);
        title(['Q = ',num2str(qf)])
    end
end

