%% Tests clear_buffer and parse_buffer functions
% Tests for a situtation that causes duplicate data entries

config
MODE = 1;
t_0 = 0;

% Initialize
INPUT_BUFF = zeros(1,100);
input1 = hex_to_byte_array('0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x07 0x03 0x08 0x02 0x1F 0x0F 0x10');
input2 = hex_to_byte_array('0xAA 0x14 0x0B 0x50');
input3 = hex_to_byte_array('0x05 0x00 0x09 0x08 0x03 0x07 0x03 0x1F 0x0F 0x10 0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x08 0x04 0x07 0x03 0x1F 0x0F 0x10');

% First
INPUT_BUFF(1:length(input1)) = input1;
BUFF_LENGTH = length(input1);
data = parse_input_buffer;
assert(BUFF_LENGTH == 0, 'Failed, incorrect buffer length after cleared');
assert(data(2) == 5, 'Failed, incorrect data');
assert(data(3) == 0, 'Failed, incorrect data');
assert(data(4) == 9, 'Failed, incorrect data');
assert(data(5) == 7, 'Failed, incorrect data');
assert(data(6) == 3, 'Failed, incorrect data');
assert(data(7) == 8, 'Failed, incorrect data');
assert(data(8) == 2, 'Failed, incorrect data');
assert(data(9) == 31, 'Failed, incorrect data');

% Second
INPUT_BUFF(1:length(input2)) = input2;
BUFF_LENGTH = BUFF_LENGTH + length(input2);
data = parse_input_buffer;
assert(BUFF_LENGTH == 4, 'Failed, incorrect buffer length after cleared');
assert(isempty(data), 'Failed, non-empty data returned')

% Third
INPUT_BUFF(BUFF_LENGTH + (1:length(input3))) = input3;
BUFF_LENGTH = BUFF_LENGTH + length(input3);
data = parse_input_buffer;
assert(BUFF_LENGTH == 0, 'Failed, incorrect buffer length after cleared');
assert(data(1,2) == 5, 'Failed, incorrect data');
assert(data(1,3) == 0, 'Failed, incorrect data');
assert(data(1,4) == 9, 'Failed, incorrect data');
assert(data(1,5) == 8, 'Failed, incorrect data');
assert(data(1,6) == 3, 'Failed, incorrect data');
assert(data(1,7) == 7, 'Failed, incorrect data');
assert(data(1,8) == 3, 'Failed, incorrect data');
assert(data(1,9) == 31, 'Failed, incorrect data');
assert(data(2,2) == 5, 'Failed, incorrect data');
assert(data(2,3) == 0, 'Failed, incorrect data');
assert(data(2,4) == 9, 'Failed, incorrect data');
assert(data(2,5) == 8, 'Failed, incorrect data');
assert(data(2,6) == 4, 'Failed, incorrect data');
assert(data(2,7) == 7, 'Failed, incorrect data');
assert(data(2,8) == 3, 'Failed, incorrect data');
assert(data(2,9) == 31, 'Failed, incorrect data');


%% Tests made up edge case

config
MODE = 1;
t_0 = 0;

% Gotta make sure the edge case works correctly
INPUT_BUFF = zeros(1,100);
input1 = hex_to_byte_array('0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x07 0x03 0x08 0x02 0x1F 0x0F 0x10');
input2 = hex_to_byte_array('0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x08 0x03 0x07 0x03 0x1F 0x0F');
input3 = hex_to_byte_array('0x10 0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x08 0x04 0x07 0x03 0x1F 0x0F 0x10');
input4 = hex_to_byte_array('0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x07 0x03 0x08 0x02 0x1F 0x0F 0x10 0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x08 0x03 0x07 0x03 0x1F 0x0F');

% First
INPUT_BUFF(1:length(input1)) = input1;
BUFF_LENGTH = length(input1);
data = parse_input_buffer;
assert(BUFF_LENGTH == 0, 'Failed, incorrect buffer length after cleared');
assert(data(2) == 5, 'Failed, incorrect data');
assert(data(3) == 0, 'Failed, incorrect data');
assert(data(4) == 9, 'Failed, incorrect data');
assert(data(5) == 7, 'Failed, incorrect data');
assert(data(6) == 3, 'Failed, incorrect data');
assert(data(7) == 8, 'Failed, incorrect data');
assert(data(8) == 2, 'Failed, incorrect data');
assert(data(9) == 31, 'Failed, incorrect data');

% Second
INPUT_BUFF(1:length(input2)) = input2;
BUFF_LENGTH = BUFF_LENGTH + length(input2);
data = parse_input_buffer;
assert(BUFF_LENGTH == 13, 'Failed, incorrect buffer length after cleared');
assert(isempty(data), 'Failed, non-empty data returned')

% Third
INPUT_BUFF(BUFF_LENGTH + (1:length(input3))) = input3;
BUFF_LENGTH = BUFF_LENGTH + length(input3);
data = parse_input_buffer;
assert(BUFF_LENGTH == 0, 'Failed, incorrect buffer length after cleared');
assert(data(1,2) == 5, 'Failed, incorrect data');
assert(data(1,3) == 0, 'Failed, incorrect data');
assert(data(1,4) == 9, 'Failed, incorrect data');
assert(data(1,5) == 8, 'Failed, incorrect data');
assert(data(1,6) == 3, 'Failed, incorrect data');
assert(data(1,7) == 7, 'Failed, incorrect data');
assert(data(1,8) == 3, 'Failed, incorrect data');
assert(data(1,9) == 31, 'Failed, incorrect data');
assert(data(2,2) == 5, 'Failed, incorrect data');
assert(data(2,3) == 0, 'Failed, incorrect data');
assert(data(2,4) == 9, 'Failed, incorrect data');
assert(data(2,5) == 8, 'Failed, incorrect data');
assert(data(2,6) == 4, 'Failed, incorrect data');
assert(data(2,7) == 7, 'Failed, incorrect data');
assert(data(2,8) == 3, 'Failed, incorrect data');
assert(data(2,9) == 31, 'Failed, incorrect data');

% Fourth
INPUT_BUFF(1:length(input4)) = input4;
BUFF_LENGTH = length(input4);
data = parse_input_buffer;
assert(BUFF_LENGTH == 13, 'Failed, incorrect buffer length after cleared');
assert(numel(data) == 9, 'Failed, incorrect data');
assert(data(2) == 5, 'Failed, incorrect data');
assert(data(3) == 0, 'Failed, incorrect data');
assert(data(4) == 9, 'Failed, incorrect data');
assert(data(5) == 7, 'Failed, incorrect data');
assert(data(6) == 3, 'Failed, incorrect data');
assert(data(7) == 8, 'Failed, incorrect data');
assert(data(8) == 2, 'Failed, incorrect data');
assert(data(9) == 31, 'Failed, incorrect data');


%% I think this causes the buffer to not be cleared properly.
% Complete first packet, incomplete second packet

config
MODE = 1;
t_0 = 0;

INPUT_BUFF = zeros(1,100);
input1 = hex_to_byte_array('0xAA 0x14 0x0B 0x50 0x05 0x00 0x09 0x07 0x03 0x08 0x02 0x1F 0x0F 0x10 0xAA');
input2 = hex_to_byte_array('0x14 0x0B 0x50 0x05 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x0F 0x10');

% First
INPUT_BUFF(1:length(input1)) = input1;
BUFF_LENGTH = length(input1);
data = parse_input_buffer;
assert(BUFF_LENGTH == 1, 'Failed, incorrect buffer length after cleared');
assert(data(2) == 5, 'Failed, incorrect data');
assert(data(3) == 0, 'Failed, incorrect data');
assert(data(4) == 9, 'Failed, incorrect data');
assert(data(5) == 7, 'Failed, incorrect data');
assert(data(6) == 3, 'Failed, incorrect data');
assert(data(7) == 8, 'Failed, incorrect data');
assert(data(8) == 2, 'Failed, incorrect data');
assert(data(9) == 31, 'Failed, incorrect data');

% Add next packet
INPUT_BUFF((BUFF_LENGTH:length(input2))+1) = input2;
BUFF_LENGTH = BUFF_LENGTH + length(input2);
data = parse_input_buffer;
assert(BUFF_LENGTH == 0, 'Failed, incorrect buffer length after cleared');
assert(data(2) == 5, 'Failed, incorrect data');
assert(data(3) == 0, 'Failed, incorrect data');
assert(data(4) == 1, 'Failed, incorrect data');
assert(data(5) == 2, 'Failed, incorrect data');
assert(data(6) == 3, 'Failed, incorrect data');
assert(data(7) == 4, 'Failed, incorrect data');
assert(data(8) == 5, 'Failed, incorrect data');
assert(data(9) == 6, 'Failed, incorrect data');

disp('Test_Clear_and_Parse PASSED')