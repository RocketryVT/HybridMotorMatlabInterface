function [ a, b, c, d ] = float_to_bytes( x )
%FLOAT_TO_BINARY Converts a number to a float, then to unsigned char values
%   Converts Matlab decimal numbers which are doubles to a format that can
%   be output as a series of four unsigned char values. It is important to
%   remember that MATLAB uses doubles to represent decimal numbers, and
%   that they are converted to floats in this function

xFF = hex_to_byte_array('0xFF');

x = cast(x,'single');
x = typecast(x,'uint32');

a = bitand(bitshift(x, -24),xFF);
b = bitand(bitshift(x, -16),xFF);
c = bitand(bitshift(x, -8),xFF);
d = bitand(x,xFF);

end

