% function performs the idct2 on 8x8 blocks of data
% and returns array of ycbcr values

% inputs:
%   dct_array           array of reconstructed dct2 values
%   image_size          1x3 array containing dimensions of input image

% outputs:
%   ycbcr_array         reconstructed ycbcr array of values

function ycbcr_array = rev_IDCT(dct_array,image_size)
    
    % isolate RGB channels
    r_channel = dct_array(:,:,1);
    g_channel = dct_array(:,:,2);
    b_channel = dct_array(:,:,3);

    % create empty matrix to store IDCT values
    idct_image = zeros(size(dct_array));
    
    % use loop to initialize matrix
    % perform IDCT on each 8x8 block from each channel
    for row = 1:length(r_channel(:,1))/8
        for col = 1:length(r_channel(1,:))/8
            idct_image(8*(row-1)+1:8*row,8*(col-1)+1:8*col,1) ... 
                = (idct2(r_channel(8*(row-1)+1:8*row,...
                8*(col-1)+1:8*col)));
            idct_image(8*(row-1)+1:8*row,8*(col-1)+1:8*col,2) ...
                = (idct2(g_channel(8*(row-1)+1:8*row,...
                8*(col-1)+1:8*col)));
            idct_image(8*(row-1)+1:8*row,8*(col-1)+1:8*col,3) ...
                = (idct2(b_channel(8*(row-1)+1:8*row,...
                8*(col-1)+1:8*col)));
        end
    end
    
    % remove padded regions to get image of original size
    img = zeros(image_size(1),image_size(2),3);
    img(:,:,1) = idct_image(1:image_size(1),1:image_size(2),1);
    img(:,:,2) = idct_image(1:image_size(1),1:image_size(2),2);
    img(:,:,3) = idct_image(1:image_size(1),1:image_size(2),3);
    
    % convert image from double to uint8
    ycbcr_array = uint8(img);
    
end