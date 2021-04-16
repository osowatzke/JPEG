% takes in original image and noisy image to calculate MSE,
% and displays difference image

% both inputs have to be in the same form i.e. both share uint8 format
% image input order does not matter

function mse = diff_mse(img1, img2)
    
    % compute differences between noisy img and original img
    diff = imabsdiff(img1,img2);
    
    % display difference image
    figure;
    imshow(diff);
    
    % compute MSE 
    mse = immse(img1, img2);
    
    % display MSE value
    fprintf('MSE = %.3f \n',mse);


   