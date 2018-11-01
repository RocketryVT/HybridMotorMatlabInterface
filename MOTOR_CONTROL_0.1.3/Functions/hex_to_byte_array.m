function [ bytes ] = hex_to_byte_array( str )
%HEX_TO_BYTE_ARRAY Decodes a string of hex values to an array of bytes
%
% Matt Marti
% 1/11/18
%
% INPUT
% str -> string, Example: "0x77 0x6F 0x72 0x64"
%
% OUTPUT
% bytes -> array, Example: [ 119 111 114 100 ]


% Count instances
cnt = 0;
i = 1;
while i < length(str) - 2
    if strcmp('0x', str(i:i+1))
        cnt = cnt + 1;
        i = i + 3;
    end
    i = i + 1;
end

% Preallocate
bytes = zeros(1,cnt);

% Lexicon
j = 1;
i = 1;
while i < length(str) - 2
    if strcmp('0x', str(i:i+1))
        
        switch str(i+2)
            case '0', a = 0;
            case '1', a = 1;
            case '2', a = 2;
            case '3', a = 3;
            case '4', a = 4;
            case '5', a = 5;
            case '6', a = 6;
            case '7', a = 7;
            case '8', a = 8;
            case '9', a = 9;
            case 'A', a = 10;
            case 'B', a = 11;
            case 'C', a = 12;
            case 'D', a = 13;
            case 'E', a = 14;
            case 'F', a = 15;
            case 'a', a = 10;
            case 'b', a = 11;
            case 'c', a = 12;
            case 'd', a = 13;
            case 'e', a = 14;
            case 'f', a = 15;
            otherwise, error('Unrecognized character');
        end
                
        switch str(i+3)
            case '0', b = 0;
            case '1', b = 1;
            case '2', b = 2;
            case '3', b = 3;
            case '4', b = 4;
            case '5', b = 5;
            case '6', b = 6;
            case '7', b = 7;
            case '8', b = 8;
            case '9', b = 9;
            case 'A', b = 10;
            case 'B', b = 11;
            case 'C', b = 12;
            case 'D', b = 13;
            case 'E', b = 14;
            case 'F', b = 15;
            case 'a', b = 10;
            case 'b', b = 11;
            case 'c', b = 12;
            case 'd', b = 13;
            case 'e', b = 14;
            case 'f', b = 15;
            otherwise, error('Unrecognized character');
        end

        bytes(j) = a*16 + b;
        j = j + 1;
        i = i + 3;
        
    end
    i = i + 1;
end

end

