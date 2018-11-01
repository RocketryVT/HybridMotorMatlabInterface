function [ x ] = bytes_to_float( a, b, c, d )
%BYTES_TO_FLOAT Converts four unsigned char values to the corrosponding 32
%bit floating point value

a = cast(a, 'uint32');
b = cast(b, 'uint32');
c = cast(c, 'uint32');
d = cast(d, 'uint32');

aa = bitshift(a, 24);
bb = bitshift(b, 16);
cc = bitshift(c, 8);
dd = d;
x = bitor(bitor(bitor(aa, bb), cc), dd);

x = typecast(x,'single');


end

