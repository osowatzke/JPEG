% function calculates quantized image data

% inputs:
%   dct_array           MxNx3 array of dct values
%   qf                  Quality factor used to scale quantization table

% outputs:
%   quant_array         MxNx3 array of quantized values

function quant_array = quantizer(dct_array, qf)
    
    % defualt quantization table 
    Q = [16, 11, 10, 16, 24, 40, 51, 61; ...
        12, 12, 14, 19, 26, 58, 60, 55; ...
        14, 13, 16, 24, 40, 57, 69, 56; ...
        14, 17, 22, 29, 51, 87, 80, 62; ...
        18, 22, 37, 56, 68, 109, 103, 77; ...
        24, 35, 55, 64, 81, 104, 113, 92; ...
        49, 64, 78, 87, 103, 121, 120, 101; ...
        72, 92, 95, 98, 112, 100, 103, 99];
    
    % Miano's (corrected) f(qf)
    fqf = exp(6*(50-qf)/50*log(2));
    
    % modified quantization table
    Q = round(fqf.*Q);
    
    % empty array of quantized image data
    quant_array = zeros(size(dct_array));
    
    % for each 8x8 block of RGB data calculate round(X[l,k]/Q[l,k])
    for row = 1:length(dct_array(:,1,1))/8
        for col = 1:length(dct_array(1,:,1))/8
            for rgb = 1:3
                quant_array(8*(row-1)+1:8*row,8*(col-1)+1:8*col,rgb) ...
                    = round(dct_array(8*(row-1)+1:8*row,...
                    8*(col-1)+1:8*col,rgb)./Q);
            end
        end
    end
end