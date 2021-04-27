% function takes a MxNx3 array and returns a 1x(M*N*3) vector
% which is zig-zag encoded
function imvector = zig_zag(imdata)
    
    % order of zig-zag indices in 8x8 block
    zigzag = [ 1  2  6  7 15 16 28 29;...
               3  5  8 14 17 27 30 43;...
               4  9 13 18 26 31 42 44;...
              10 12 19 25 32 41 45 54;...
              11 20 24 33 40 46 53 55;...
              21 23 34 39 47 52 56 61; ...
              22 35 38 48 51 57 60 62; ...
              36 37 49 50 58 59 63 64];
      
    % transform image into 1x64 vector
    zz1 = reshape(zigzag,1,64);
    
    % sort to determine index order
    [~, I] = sort(zz1);
    
    % determine size of image
    [H, W, RGB] = size(imdata);
    
    % empty image vector
    imvector = zeros(1,H*W*RGB);
    
    % encode row by row through blocks 
    % encode R then G then B
    for m = 1:H/8
        for n = 1:W/8
            for k = 1:RGB
                % determine 8x8 block of data
                block = imdata(8*(m-1)+1:8*m,8*(n-1)+1:8*n,k);
                % reshape to a 1x64 vector
                vec = reshape(block,1,64);
                % zig-zag encode using incides found and save into image
                % vector
                imvector(64*(m+n+k-3)+1:64*(m+n+k-2)) = vec(I);
            end
        end
    end      
end