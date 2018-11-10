%% Parameters

% Globals
global SERIAL_PORT INPUT_BUFF BUFF_LENGTH DATA INDEX MODE IS_PLOTTING START_TIME t_0 SIM_DATA ISSAVED SIM_VER SIM_DEX RECORDED_DATA_VERSION COMLOG COMDEX ARDMODE

% COM Port data
port_number = 'COM4';
baud_rate = 38400;
timeout = 1;
BUFF = 10000;

% Arduino parameters
data_rate = 0.05;
max_time = 20;
IS_CONNECTED = true;

% GUI and controls
update_rate = 0.05;
min_P = 0;
max_P = 1500;
min_T = 0;
max_T = 500;
min_Thr = 0;
max_Thr = 100;
plot_timebuff = 0.34;

% Program data
data_cols = 12;

% Output COM port dump at end of test
savedump = true;
