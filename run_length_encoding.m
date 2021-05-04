% function performs run length encoding of zeros

% inputs:
%   in_str          string of input values

% outputs:
%   out_str         string of output values

function out_str = run_length_encoding(in_str)
    
    % new_str is 1 if the last digit was not a 0
    new_str = 1;
    
    % length of encoded string
    len = 0;
    
    % loop through input string
    for n = 1:length(in_str)
        
        % if input value is 0
        if in_str(n) == 0
            
            % if this is the first time 0 is found, add 0 to string
            % and a length argument for the number of zeros
            if new_str == 1
                len = len+2;              
            end
            
            % keep track of a zero being found last iteration
            new_str = 0;
            
        % if value is not a zero
        else
       
            % increment length of string for new non-zero value
            len = len + 1;
            
            % next time string is found append a 0 and a length argument
            new_str = 1;
        end        
    end
    
    % initialize string for encoded values
    out_str = zeros(1,len);
    
    % new_str is 1 if the last digit was not a 0
    new_str = 1;
    
    % index in new string (index before use)
    i = 0;
    
    % loop through input string
    for n = 1:length(in_str)
        
        % if input value is 0
        if in_str(n) == 0
            
            % if this is the first time 0 is found, add value to string
            % and a length argument for the number of zeros
            if new_str == 1
                out_str(i+1) = in_str(n);
                i = i+2;   
                out_str(i) = 0;
            end
            
            % keep track of a zero being found last iteration
            new_str = 0;
            
            % increment length argument
            out_str(i) = out_str(i) + 1;
            
        % if value is not a zero
        else
            
            % increment index 
            i = i + 1;
            
            % update output string
            out_str(i) = in_str(n);
            
            % next time string is found append a 0 and a length argument
            new_str = 1;
        end        
    end
end