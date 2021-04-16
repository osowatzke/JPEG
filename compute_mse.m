% takes in original image and noisy image to calculate MSE

% both inputs have to be in the same form i.e. both share uint8 format
% image input order does not matter

function mse = compute_mse(img1, img2)
    
    % compute MSE 
    mse = immse(img1, img2);
    
    % display MSE value
    fprintf('MSE = %.3f \n',mse);


   