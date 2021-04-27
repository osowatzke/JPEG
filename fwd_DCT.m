function dct_image = fwd_DCT(imdata)
    
    % determine image size
    [m, n] = size(imdata(:,:,1));
    
    % decide whether to pad m and n
    pad_m = mod(m,8) > 0;
    pad_n = mod(n,8) > 0;
    
    % pad rows and columns to be multiples of 8
    padded_R = padarray(imdata(:,:,1), ...
        [pad_m*(8-mod(m,8)) pad_n*(8-mod(n,8))], 'replicate', 'post');
    padded_G = padarray(imdata(:,:,2), ...
        [pad_m*(8-mod(m,8)) pad_n*(8-mod(n,8))], 'replicate', 'post');
    padded_B = padarray(imdata(:,:,3), ...
        [pad_m*(8-mod(m,8)) pad_n*(8-mod(n,8))], 'replicate', 'post');
    
    % create empty matrix of DCT coefficients
    dct_image = zeros([size(padded_R), 3]);
    
    % use loop to initialize matrix
    for m = 1:length(padded_R(:,1))/8
        for n = 1:length(padded_R(1,:))/8
            dct_image(8*(m-1)+1:8*m,8*(n-1)+1:8*n,1) ... 
                = dct2(double(padded_R(8*(m-1)+1:8*m,8*(n-1)+1:8*n)));
            dct_image(8*(m-1)+1:8*m,8*(n-1)+1:8*n,2) ...
                = dct2(double(padded_G(8*(m-1)+1:8*m,8*(n-1)+1:8*n)));
            dct_image(8*(m-1)+1:8*m,8*(n-1)+1:8*n,3) ...
                = dct2(double(padded_B(8*(m-1)+1:8*m,8*(n-1)+1:8*n)));
        end
    end
end