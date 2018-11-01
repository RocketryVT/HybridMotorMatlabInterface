%% Tests that the 0x51 packet is decoded correctly by MATLAB

addpath('Functions')

global INPUT_BUFF BUFF_LENGTH MODE t_0 ARDMODE
MODE = 2;
t_0 = 0;
xFF = hex_to_byte_array('0xFF');

% Construct sample transmitted packet data for 0x51
hdr = hex_to_byte_array('0xAA 0x14');
size = cast(35,'uint8');
pckt = hex_to_byte_array('0x52');
time = cast(123456, 'uint32');
mode = 2;
status = cast(0, 'uint16');
po = 1;
pc = 2;
to = 3;
tc = 4;
tpc = 5;
th = 6;
nd = hex_to_byte_array('0x1F');
ch = [15 16];

% Construct sample buffer for 0x51
INPUT_BUFF = [];
INPUT_BUFF = [INPUT_BUFF, hdr];
INPUT_BUFF = [INPUT_BUFF, size, pckt];
bits_time = bitand(bitshift(time, [-24 -16 -8 0]), xFF);
INPUT_BUFF = [INPUT_BUFF, bits_time];
bits_status = bitand(bitshift(status, [-8 0]), xFF);
INPUT_BUFF = [INPUT_BUFF, mode, bits_status];
[a, b, c, d] = float_to_bytes(po);
INPUT_BUFF = [INPUT_BUFF, a, b, c, d];
[a, b, c, d] = float_to_bytes(pc);
INPUT_BUFF = [INPUT_BUFF, a, b, c, d];
[a, b, c, d] = float_to_bytes(to);
INPUT_BUFF = [INPUT_BUFF, a, b, c, d];
[a, b, c, d] = float_to_bytes(tc);
INPUT_BUFF = [INPUT_BUFF, a, b, c, d];
[a, b, c, d] = float_to_bytes(tpc);
INPUT_BUFF = [INPUT_BUFF, a, b, c, d];
[a, b, c, d] = float_to_bytes(th);
INPUT_BUFF = [INPUT_BUFF, a, b, c, d];
INPUT_BUFF = [INPUT_BUFF, nd];
INPUT_BUFF = [INPUT_BUFF, ch];
INPUT_BUFF = cast(INPUT_BUFF,'double');

% Parse input buffer and test
BUFF_LENGTH = length(INPUT_BUFF);
data_curr = parse_input_buffer;
assert(BUFF_LENGTH == 0, 'Failed, incorrect buffer length after cleard');
assert(data_curr(1) == time, 'Failed, incorrect value on 1');
assert(data_curr(2) == mode, 'Failed, incorrect value on 2');
assert(data_curr(3) == status, 'Failed, incorrect value on 3');
assert(data_curr(4) == po, 'Failed, incorrect value on 4');
assert(data_curr(5) == pc, 'Failed, incorrect value on 5');
assert(data_curr(6) == to, 'Failed, incorrect value on 6');
assert(data_curr(7) == tc, 'Failed, incorrect value on 7');
assert(data_curr(8) == tpc, 'Failed, incorrect value on 8');
assert(data_curr(9) == th, 'Failed, incorrect value on 9');
assert(data_curr(10) == nd, 'Failed, incorrect value on 10');
assert(ARDMODE == mode);

% Results
disp('Test_Packet_0x52 PASSED')