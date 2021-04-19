function idct_image = rev_IDCT(r,c,imdata)
    
    % isolate RGB channels
    r_channel = imdata(:,:,1);
    g_channel = imdata(:,:,2);
    b_channel = imdata(:,:,3);

    % create empty matrix to store IDCT values
    idct_image = imdata;
    
    % use loop to initialize matrix
    % perform IDCT on each 8x8 block from each channel
    for m = 1:length(r_channel(:,1))/8
        for n = 1:length(r_channel(1,:))/8
            idct_image(8*(m-1)+1:8*m,8*(n-1)+1:8*n,1) ... 
                = (idct2(r_channel(8*(m-1)+1:8*m,8*(n-1)+1:8*n)));
            idct_image(8*(m-1)+1:8*m,8*(n-1)+1:8*n,2) ...
                = (idct2(g_channel(8*(m-1)+1:8*m,8*(n-1)+1:8*n)));
            idct_image(8*(m-1)+1:8*m,8*(n-1)+1:8*n,3) ...
                = (idct2(b_channel(8*(m-1)+1:8*m,8*(n-1)+1:8*n)));
        end
    end
    
    % remove padded regions to get image of original size
    img = zeros(r,c,3);
    img(:,:,1) = idct_image(1:r,1:c,1);
    img(:,:,2) = idct_image(1:r,1:c,2);
    img(:,:,3) = idct_image(1:r,1:c,3);
    
    % convert image from double to uint8
    idct_image = uint8(img);
end