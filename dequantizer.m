function dequant_imdata = dequantizer(quant_imdata, qf)

    % defualt Q
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

    dequant_imdata = zeros(size(quant_imdata));

    % for each 8x8 block of RGB data calculate round(X[l,k]/Q[l,k])
        for m = 1:length(quant_imdata(:,1,1))/8
            for n = 1:length(quant_imdata(1,:,1))/8
                for k = 1:3
                    dequant_imdata(8*(m-1)+1:8*m,8*(n-1)+1:8*n,k) ...
                        = (quant_imdata(8*(m-1)+1:8*m,8*(n-1)+1:8*n,k).*Q);
                end
            end
        end
        
        
        
        
        