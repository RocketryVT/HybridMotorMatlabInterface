function [  ] = clear_input_buffer( ii )
%CLEAR_INPUT_BUFFER Clears input buffer up to specified index

config;

% If no arguments are given
if nargin == 0
    ii = 0;
end

% Clear buffer up to ii
if (ii)
    for i = ii:BUFF_LENGTH
        INPUT_BUFF(i-ii+1) = INPUT_BUFF(i);
    end
    BUFF_LENGTH = BUFF_LENGTH - ii + 1;
else
    BUFF_LENGTH = 0;
end

end

