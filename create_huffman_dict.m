% function creates huffman dictionary based on how frequently values occur
% in quantized image data
function huff_dict = create_huffman_dict(imdata)

    % determine unique values in MxNx3 image array
    unique_vals =unique(imdata);
    
    % empty array with number of times each value occurs
    freq = zeros(1,length(unique_vals));
    
    % determine the number of times each value occurs
    for k = 1:length(unique_vals)
        freq(k) = sum(sum(sum(imdata == unique_vals(k),1),2),3);
    end
    
    % sort number of occurences from smallest to largest
    [freq, I] = sort(freq);
    
    % create cell array of indices
    index_array = num2cell(I);
    
    % create empty cell array for huffman encoding values
    huff_array = cell(1,length(unique_vals));
    
    % perform huffman encoding until there is only node
    while length(freq) >= 2
        
        % append values to the binary arrays within huffman cell arrays
        huff_array = append_huff_array(huff_array,0,index_array{1});
        huff_array = append_huff_array(huff_array,1,index_array{2});
        
        % reform top level cell array so it only contains largest nodes
        % this does not need to be done the last time through the while
        % loop
        if length(freq) > 2
            
            % frequencies at each node
            freq = [freq(1)+freq(2), freq(3:end)];
            
            % update cell array of indices
            index_array = {{index_array{1}, index_array{2}}, index_array{3:end}};
            
            % sort array of frequencies and cell array of indices
            [freq, I] = sort(freq);
            index_array = index_array(I);
        else 
            break;
        end      
    end
    
    % append '0' to all huffman arrays (base node)
    for k = 1:length(huff_array)
        huff_array{k} = [0, huff_array{k}];
    end
    
    % create huffman dictionary
    huff_dict = cell(length(unique_vals),2);
    huff_dict(:,1) = num2cell(unique_vals);
    huff_dict(:,2) = huff_array;
end