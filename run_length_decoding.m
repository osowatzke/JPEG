% function performs run length decoding of zeros

% inputs:
%   in_str          string of input values

% outputs:
%   out_str         string of output values

function out_str = run_length_decoding(in_str)
    
    % variable to hold length of output string
    len = 0;
    
    % variable determines if last value was zero
    last_val_zero = 0;
    
    % loop through input string looking for zeros
    for n = 1:length(in_str)
        
        % if the value is zero look for length argument in next digit
        if in_str(n) == 0
            last_val_zero = 1;
            
        % if the value is not zero do not look for length argument in the 
        % next digit
        else
            
            % if last value was a zero append length argument
            if last_val_zero == 1
                len = len + in_str(n);
             
            % if last value is not zero increment length argument
            else
                len = len + 1;
            end
            
            % notate that this value was not a zero
            last_val_zero = 0;
        end
    end
    
    % initialize empty string to hold decoded values
    out_str = zeros(1,len);
    
    % index in new string
    % initialize as 0
    i = 0;
    
    % variable determines if last value was zero
    last_val_zero = 0;
    
    % loop through input string looking for zeros
    for n = 1:length(in_str)
        
        % if the value is zero look for length argument in next digit
        if in_str(n) == 0
            last_val_zero = 1;
            
        % if the value is not zero do not look for length argument in the 
        % next digit
        else
            
            % if last value was a zero loop to initialize output string
            if last_val_zero == 1
                for j = 1:in_str(n)
                    % increment index
                    i = i + 1;
                    % save zeros to output string
                    out_str(i) = 0;
                end
             
            % if last value is not zero
            else
                % increment index
                i = i + 1;
                % save value to output string
                out_str(i) = in_str(n);
            end
            
            % notate that this value was not a zero
            last_val_zero = 0;
        end
    end
            
end