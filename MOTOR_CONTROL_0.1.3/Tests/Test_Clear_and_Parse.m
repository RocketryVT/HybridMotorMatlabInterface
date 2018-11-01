%% Tests clear_buffer and parse_buffer functions
% The indexing on these functions are tricky and cause dropped packets when
% not working correclty. These tests aim to fix that

global INPUT_BUFF BUFF_LENGTH MODE t_0
MODE = 1;
t_0 = 0;

% Tests ending on random numbers
INPUT_BUFF = [84 12 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 44 20 10 ];
BUFF_LENGTH = length(INPUT_BUFF);
parse_input_buffer;
assert(BUFF_LENGTH == 3, 'Failed 1, incorrect buffer length after cleard');
assert(INPUT_BUFF(1) == 44, 'Failed 1, incorrect value on 1');
assert(INPUT_BUFF(2) == 20, 'Failed 1, incorrect value on 2');
assert(INPUT_BUFF(3) == 10, 'Failed 1, incorrect value on 3');

% Tests ending on exact number of packets
INPUT_BUFF = [84 12 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 ];
BUFF_LENGTH = length(INPUT_BUFF);
parse_input_buffer;
assert(BUFF_LENGTH == 0, 'Failed 2, incorrect buffer length after cleard');

% Tests ending on header
INPUT_BUFF = [84 12 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 10 ];
BUFF_LENGTH = length(INPUT_BUFF);
parse_input_buffer;
assert(BUFF_LENGTH == 3, 'Failed 3, incorrect buffer length after cleard');
assert(INPUT_BUFF(1) == 170, 'Failed 3, incorrect value on 1');
assert(INPUT_BUFF(2) == 20, 'Failed 3, incorrect value on 2');
assert(INPUT_BUFF(3) == 10, 'Failed 3, incorrect value on 3');

% Tests ending on header and incomplete data
INPUT_BUFF = [84 12 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 10 44 55 ];
BUFF_LENGTH = length(INPUT_BUFF);
parse_input_buffer;
assert(BUFF_LENGTH == 5, 'Failed 4, incorrect buffer length after cleard');
assert(INPUT_BUFF(1) == 170, 'Failed 4, incorrect value on 1');
assert(INPUT_BUFF(2) == 20, 'Failed 4, incorrect value on 2');
assert(INPUT_BUFF(3) == 10, 'Failed 4, incorrect value on 3');
assert(INPUT_BUFF(4) == 44, 'Failed 4, incorrect value on 4');
assert(INPUT_BUFF(5) == 55, 'Failed 4, incorrect value on 5');


% Tests ending on header and incomplete data with missing the last byte
INPUT_BUFF = [84 12 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 11 80 5 0 1 2 3 4 5 31 15 16 170 20 11 80 5 0 1 2 3 4 5 31 15 ];
BUFF_LENGTH = length(INPUT_BUFF);
parse_input_buffer;
assert(BUFF_LENGTH == 13, 'Failed 5, incorrect buffer length after cleard');
assert(INPUT_BUFF(1) == 170, 'Failed 5, incorrect value on 1');
assert(INPUT_BUFF(2) == 20, 'Failed 5, incorrect value on 2');
assert(INPUT_BUFF(3) == 11, 'Failed 5, incorrect value on 3');
assert(INPUT_BUFF(4) == 80, 'Failed 5, incorrect value on 4');
assert(INPUT_BUFF(5) == 5, 'Failed 5, incorrect value on 5');
assert(INPUT_BUFF(6) == 0, 'Failed 5, incorrect value on 6');
assert(INPUT_BUFF(7) == 1, 'Failed 5, incorrect value on 7');
assert(INPUT_BUFF(8) == 2, 'Failed 5, incorrect value on 8');
assert(INPUT_BUFF(9) == 3, 'Failed 5, incorrect value on 9');
assert(INPUT_BUFF(10) == 4, 'Failed 5, incorrect value on 10');
assert(INPUT_BUFF(11) == 5, 'Failed 5, incorrect value on 11');
assert(INPUT_BUFF(12) == 31, 'Failed 5, incorrect value on 12');
assert(INPUT_BUFF(13) == 15, 'Failed 5, incorrect value on 13');


disp('Test_Clear_and_Parse PASSED')