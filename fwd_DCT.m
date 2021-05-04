% function takes the dct2 of the image in 8x8 blocks

% inputs:
%   ycbcr_array         MxNx3 uint8 image array 

% outputs:
%   dct_array           MxNx3 double array of dct2 values

function dct_array = fwd_DCT(ycbcr_array)
    
    % determine image size
    [col, row] = size(ycbcr_array(:,:,1));
    
    % decide whether to pad columns and rows
    pad_col = mod(col,8) > 0;
    pad_row = mod(row,8) > 0;
    
    % pad rows and columns to be multiples of 8
    padded_R = padarray(ycbcr_array(:,:,1), ...
        [pad_col*(8-mod(col,8)) pad_row*(8-mod(row,8))],...
        'replicate', 'post');
    padded_G = padarray(ycbcr_array(:,:,2), ...
        [pad_col*(8-mod(col,8)) pad_row*(8-mod(row,8))], ...
        'replicate', 'post');
    padded_B = padarray(ycbcr_array(:,:,3), ...
        [pad_col*(8-mod(col,8)) pad_row*(8-mod(row,8))], ...
        'replicate', 'post');
    
    % create empty matrix of DCT coefficients
    dct_array = zeros([size(padded_R), 3]);
    
    % use loop to initialize matrix
    for row = 1:length(padded_R(:,1))/8
        for col = 1:length(padded_R(1,:))/8
            dct_array(8*(row-1)+1:8*row,8*(col-1)+1:8*col,1) ... 
                = dct2(double(padded_R(8*(row-1)+1:8*row,...
                8*(col-1)+1:8*col)));
            dct_array(8*(row-1)+1:8*row,8*(col-1)+1:8*col,2) ... 
                = dct2(double(padded_G(8*(row-1)+1:8*row,...
                8*(col-1)+1:8*col)));
            dct_array(8*(row-1)+1:8*row,8*(col-1)+1:8*col,3) ... 
                = dct2(double(padded_B(8*(row-1)+1:8*row,...
                8*(col-1)+1:8*col)));
        end
    end
end