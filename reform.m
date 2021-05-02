% function forms MxNx3 array of quantized values from image vector 
% perfom zig-zag decoding

% inputs:
%   imvector        1x(M*N*3) vector of quantized values
%   imsize          size of input image

% outputs:
%   imdata          MxNx3 array of image data

function imdata = reform(imvector, imsize) 
    
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
    [~,I] = sort(zz1);
    
    % determine order of indices to reverse zig-zagging
    [~,I] = sort(I);
    
    % create empty array of image data
    imdata = zeros(imsize);
    
    % loop reforms MxNx3 image from 1x(M*N*3) vector
    % image is reformed using 8x8 blocks of data which are placed 
    % row by row
    for row = 1:imsize(1)/8
        for col = 1:imsize(2)/8
            for rgb = 1:imsize(3)
                % take 64 vector entries
                start_index = imsize(2)*8*3*(row-1)+64*3*(col-1)+64*(rgb-1);
                vector_entries = imvector(start_index+1:start_index+64);
                % undo zig-zag encoding
                vector_entries = vector_entries(I);
                % reform 8x8 block from vector entries
                block = reshape(vector_entries,8,8);
                % save block to image array
                imdata(8*(row-1)+1:8*row,8*(col-1)+1:8*col,rgb) = block;
            end
        end
    end
end