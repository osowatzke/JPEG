function plots_generator()
    
    % hardcode image_path
    image_path = './test_images/cockatoo.jpg';

    % 'Finding the optimal Q value for images with different PSNR values'
    % plot MSE vs Q at different PSNR settings
    qf_array = [1,10:10:80]; % Q values
    psnr_array = (10:10:50); % PSNR values
    % returns plot of mse vs q
    figure; plot_mse_vs_q(image_path,psnr_array,qf_array);
    
    % 'Observing MSE for various Q values'
    % plot MSE vs Q for image at minimal noise 
    qf_array = [1,10:10:80]; % Q values
    figure; plot_mse_vs_q(image_path,80,qf_array);

    % 'Given a noisy image, how well can the system remove the noise at 
    % different Q values?'
    qf_array = [1,10:10:80]; % set quality factor values
    PSNR = 10; % set noise for noisy image
    % currently only takes in qf_array size 9 to generate 3x3 subplot
    plot_denoise(image_path,PSNR,qf_array);

    % 'How much space can we save using different Q values?'
    qf_array = [1,10:10:80]; % Q values
    PSNR = 80; % set noise of image
    % currently only takes in qf_array size 9 to generate 3x3 subplot
    plot_space(image_path,PSNR,qf_array);

end