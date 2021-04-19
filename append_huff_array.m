% function appends binary values to each huffman encoded value
% this function is called recursively and appends the same binary value to 
% all children of the given node
function huff_array = append_huff_array(huff_array,val,cell)
    
    % if the input cell is a cell (i.e. is a node with children)
    % call function recursively for each child of the given node
    if iscell(cell)
        for k = 1:length(cell)
            
            % recursive function call gets the value of each cell
            huff_array = append_huff_array(huff_array,val,cell{k});
        end
    else
        
        % if cell represents encode value append binary digit to beginnary
        % of array
        huff_array{cell} = [val, huff_array{cell}];
    end
end