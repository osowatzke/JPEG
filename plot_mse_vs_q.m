function plot_mse_vs_q(image_path,psnr_array,qf_array)

% store MSE values
mse_array = zeros(length(psnr_array),length(qf_array));

for jj = 1:length(psnr_array)
    for ii = 1:length(qf_array)

        % maintain constant low noise
        PSNR = psnr_array(jj);

        % quality factor
        qf = qf_array(ii);
        
        % get MxNx3 array of data from image
        input_im_array = imread(image_path);
        
        % process image for various Q values 
        [~, ~, mse, ~, ~, ~] = ...
        im_process(input_im_array, PSNR, qf);

        % store MSE for corresponding Q value
        mse_array(jj,ii) = mse;

    end
end

% plot MSE vs Q
hold on;
for ii = 1:length(psnr_array)
    plot(qf_array,mse_array(ii,:),'DisplayName',['PSNR = ',num2str(psnr_array(ii))]);
end
grid on;
xlabel('Quality Factor (Q)');
ylabel('Mean Squared Error (MSE)');
title('MSE vs Q');
hold off;
legend;
if length(psnr_array) == 1
    legend off;
end
end