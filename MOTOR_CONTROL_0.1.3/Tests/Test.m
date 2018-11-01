%% Tests all functions in MOTORCONTROL
% To ensure everything works properly, all functions are run through this
% test script to verify them.

clear, clc, close all

%% Test hex_to_byte_array.m

clear

% Test 1
test_array = [ 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 255 ] ;
test_str = '0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0A 0x0B 0x0C 0x0D 0x0E 0x0F 0x10 0xFF';
results = hex_to_byte_array(test_str);
assert(numel(results) == numel(test_array), 'Decoded hex wrong size array');
for i = length(test_array)
    assert(results(i) == test_array(i), 'incorrect decoding of hex values');
end

% Test 2
test_array = 'test';
test_str = '0x74 0x65 0x73 0x74';
results = hex_to_byte_array(test_str);
assert(numel(results) == numel(test_array), 'Decoded hex wrong size array');
for i = length(test_array)
    assert(results(i) == test_array(i), 'incorrect decoding of hex values');
end

% Test 3
test_str = '0x0.';
try
    results = hex_to_byte_array(test_str);
    assert(false,'Failed to throw error on bad command');
catch
    % Intentionally left blank
end


%% Data parsing

config
n = 1000;
INPUT_BUFF = zeros(1,n);

tic;
a = hex_to_byte_array('0xAA 0x14 0x01 0x01 0xAA 0x14 0x01 0x02 0xAA 0x14 0x01 0x01');
BUFF_LENGTH = length(a);
INPUT_BUFF(1:BUFF_LENGTH) = a;
parse_input_buffer();
assert(BUFF_LENGTH == 0, 'INPUT BUFFER length not right after being cleared');
assert(length(INPUT_BUFF) == n, 'INPUT BUFFER length was changed when it shouldnt have been');

a = hex_to_byte_array('0xAA 0xAA 0xAA 0x14 0x01 0x01 0xAA 0x14 0x01 0x02 0xBB 0xAA 0x14 0x01 0x01 0x01 0x02 0x03');
BUFF_LENGTH = length(a);
INPUT_BUFF(1:BUFF_LENGTH) = a;
i = BUFF_LENGTH;
parse_input_buffer();
assert(prod(INPUT_BUFF(1:3) == [1 2 3]) == 1,'INPUT BUFFER not truncated properly');
assert(BUFF_LENGTH == 3, 'INPUT BUFFER length not right after being cleared');
assert(length(INPUT_BUFF) == n, 'INPUT BUFFER length was changed when it shouldnt have been');

a = hex_to_byte_array('0xAA 0x14 0x01');
BUFF_LENGTH = length(a);
INPUT_BUFF(1:BUFF_LENGTH) = a;
i = BUFF_LENGTH;
parse_input_buffer();
assert(prod(INPUT_BUFF(1:3) == hex_to_byte_array('0xAA 0x14 0x01')) == 1,'INPUT BUFFER not truncated properly');
assert(BUFF_LENGTH == 3, 'INPUT BUFFER length not right after being cleared');
assert(length(INPUT_BUFF) == n, 'INPUT BUFFER length was changed when it shouldnt have been');


%% DATA PARSING 18/03/25
% The above tests allowed some bugs to slip through
Test_Clear_and_Parse

%% DATA PARSING 18/04/08
% There were duplicate data from packets that were not duplicates but that
% got cut off
Test_Parse_NoDuplicates

%% DATA PARSING 18/04/29
% Test that the 0x51 packet is decoded correctly
Test_Packet_0x51

%% DATA PARSING 18/05/06
% Test that the 0x52 packet is decoded correctly
Test_Packet_0x52

%% End message
disp('All tests passed');