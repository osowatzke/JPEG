% calculate difference between each pixels between noisy and original img
% then displays difference image

% order of image input does not matter, 
% image inputs should share same format i.e. both -> uint8

function diff = diff_img(img1,img2)

    % compute differences between noisy img and original img
    diff = imabsdiff(img1,img2);
    
    % display difference image
    %figure;
    %imshow(diff);