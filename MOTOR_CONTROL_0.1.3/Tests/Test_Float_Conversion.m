%% Tests bytes_to_float and float_to_bytes functions
% Tests that floats will be read and transmitted correctly


% Test conversion from float to char (positive)
x = 12345.6789;
[a,b,c,d] = float_to_bytes(x);
assert(a == hex_to_byte_array('0x46'), 'float_to_bytes (positive): a is incorrect')
assert(b == hex_to_byte_array('0x40'), 'float_to_bytes (positive): b is incorrect')
assert(c == hex_to_byte_array('0xE6'), 'float_to_bytes (positive): c is incorrect')
assert(d == hex_to_byte_array('0xB7'), 'float_to_bytes (positive): d is incorrect')


% Test conversion from float to char (negative)
x = -12345.6789;
[a,b,c,d] = float_to_bytes(x);
assert(a == hex_to_byte_array('0xC6'), 'float_to_bytes (negative): a is incorrect')
assert(b == hex_to_byte_array('0x40'), 'float_to_bytes (negative): b is incorrect')
assert(c == hex_to_byte_array('0xE6'), 'float_to_bytes (negative): c is incorrect')
assert(d == hex_to_byte_array('0xB7'), 'float_to_bytes (negative): d is incorrect')


% Test conversion from chars to float (positive)
x = 12345.6789;
a = hex_to_byte_array('0x46');
b = hex_to_byte_array('0x40');
c = hex_to_byte_array('0xE6');
d = hex_to_byte_array('0xB7');
y = bytes_to_float(a,b,c,d);
assert(abs(x-y) < 1e-3, 'bytes_to_float (positive): result is incorrect');


% Test conversion from chars to float (negative)
x = -12345.6789;
a = hex_to_byte_array('0xC6');
b = hex_to_byte_array('0x40');
c = hex_to_byte_array('0xE6');
d = hex_to_byte_array('0xB7');
y = bytes_to_float(a,b,c,d);
assert(abs(x-y) < 1e-3, 'bytes_to_float (negative): result is incorrect');


% Test conversion from chars to float (Youtube example)
x = -8.21529491902680293569190591134E-34;
a = hex_to_byte_array('0x88');
b = hex_to_byte_array('0x88');
c = hex_to_byte_array('0x80');
d = hex_to_byte_array('0x00');
y = bytes_to_float(a,b,c,d);
assert(abs(x-y) < 1e-34, 'bytes_to_float (Youtube example): result is incorrect')

% Forward and backwards
x = 1234.1234;
[a,b,c,d] = float_to_bytes(x);
y = bytes_to_float(a,b,c,d);
assert(abs(x-y) < 1e-4, 'bytes_to_float (F&B): result is incorrect');


disp('Test_Float_Conversion PASSED')