%% Script to open a GUI to control the Prototype Motor
%
% Opens the GUI for control and drives background operations. Background
% operations include sending periodic signals to the Arduino to tell it to
% continue operation, updating data on the GUI, and reading and saving data
% to RAM (and a file after use).
%
% Allows user to ARM, FIRE, STOP, LOAD, SIM, SAVE functions.
% the motor. Buttons are enabled and disabled to reduce the need of 
% critical thinking during testing.
%
% Plots are updated in real time to display data from the motor.
% 
% This version implements the simulation data sent from MATLAB and returned
% by the Arduino
%
% TODO
% - Documentation
% - Implement checksum checking
% - Fix transmission of data to Arduino from MATLAB dropped packets
%
% Version 0.1.1
% 5/6/18
% Matt Marti

try
    addpath('Functions')
    addpath('Data')
catch
    % Intentionally left blank
end
close_serial_port
try
    config
catch err
    disp('Make sure the folder "Functions" is added to the path')
    err;
end
clear, clc, fclose all;

% Load parameters
config
DATA = zeros( floor(max_time/data_rate)*10, data_cols );
COMLOG = cell(floor(max_time/data_rate)*10,1 );
INPUT_BUFF = zeros(1,BUFF);
BUFF_LENGTH = 0;
MODE = 0;
ARDMODE = 0;
ISSAVED = false;
SIM_DEX = 1;
COMDEX = 1;
RECORDED_DATA_VERSION = 0;


%% Open GUI and push Arduino data to display

% Loop to read data
try
    % Open GUI
    [ window_handle, control_window ] = CONTROL_GUI;
    
    if (IS_CONNECTED)
        % Open serial port and get firmware version
        SERIAL_PORT = serial(port_number, 'BaudRate', baud_rate, 'timeout', timeout);
        fopen(SERIAL_PORT);
        fwrite(SERIAL_PORT, hex_to_byte_array('0xFF 0xFF 0xFF 0xFF'), 'uint8');
        pause(0.01);
        fwrite(SERIAL_PORT, hex_to_byte_array('0xFF 0xFF 0xFF 0xFF'), 'uint8');
        version_str = fscanf(SERIAL_PORT);

        % Write parameters to Arduino
        fwrite(SERIAL_PORT, hex_to_byte_array('0xAA 0x14 0x04 0x20'), 'uint8'); % Write parameters command
        fwrite(SERIAL_PORT, data_rate*1000, 'uint16');
        fwrite(SERIAL_PORT, max_time, 'uint8');
        
        % Initialize window firmware text
        set(window_handle.firmwaretext, 'String', version_str(1:end-1));
    end

    % Initialize window
    initialize_plots(window_handle);
    pause(0.001);
    
    % While the gui is open
    update_time = 0;
    bad_plots = 0;
    INDEX = 1; j = 1; IS_PLOTTING = false; t_0 = 0; delta_time = 0;
    tic;
    while ishandle(control_window)
        
        START_TIME = toc;
        
        m = 0;
        
        % Check that maximum fire time has not been exceeded
        if START_TIME - t_0 >= max_time + data_rate && IS_PLOTTING
            if MODE == 2 % Is real
                MODE = 3;
            elseif MODE == 5 % Is simulation
                MODE = 6;
            end
        end
        
        
        %% Communicate to Arduino
        update_input_buffer();
        data_curr = parse_input_buffer;
        send_simulated_data();


        %% Update Data
        if (MODE == 0 && IS_CONNECTED) || MODE == 1 || MODE == 2 || MODE == 3 || MODE == 5
            
            % Write collected data to stored data array
            if (MODE && ~isempty(data_curr))
                [m,n] = size(data_curr);
                [length(DATA), INDEX, m];
                DATA(INDEX:INDEX+m-1,1:n) = data_curr;
            end
            
            % Begin plotting at FIRE time and set t_0
            if ((MODE == 2 || MODE == 5) && ~IS_PLOTTING && numel(data_curr))
                IS_PLOTTING = true;
                j = INDEX;
                t_0 = data_curr(1);
            end
        end
        

        %% Update window
        
        window_handle.ModeTextBox.String = num2str(ARDMODE);
        
        % if it's time to plot
        if toc - update_time > update_rate
            
            % Update plots
            j = update_plots(window_handle, j);

            % Update timer for next update
            update_time = toc;
        end
        
        
        %% Iterate

        % Check that the algorithm didn't take longer than the data rate
        delta_time = (toc - START_TIME);
        if delta_time >= data_rate
            bad_plots = bad_plots + 1;
            DATA(INDEX,11) = bad_plots;
%             delta_time = delta_time - data_rate;
        end
        
        INDEX = INDEX + m;
        
        % Trust me, pausing for 0.01 does not work
        while data_rate > (toc - START_TIME)
            update_input_buffer();
            pause(0.005);
        end
    end
catch err
    beep % Sound is nice
    disp(err);
    disp(err.stack(1));
end

try
    endmssg = hex_to_byte_array('0xFF 0xFF 0xFF 0xFF 0xFF');
    fwrite(SERIAL_PORT, endmssg, 'uint8');
    fclose(SERIAL_PORT);
    delete(SERIAL_PORT);
catch
    try 
        fopen(SERIAL_PORT);
        fwrite(SERIAL_PORT, endmssg, 'uint8');
        fclose(SERIAL_PORT);
        delete(SERIAL_PORT);
    catch
        beep
    end
end

% Save file automatically if not already saved
try
    if (~ISSAVED)
        test_date = datestr(datetime);
        for i = 1:length(test_date)
            if strcmp(test_date(i),':')
                test_date(i) = '-';
            end
            if strcmp(test_date(i),' ')
                test_date(i) = '-';
            end
        end
        save_data(strcat('Data\R@VT_Populsion-', test_date, '.csv'));
    end
catch
    % Intentionally left blank
end

% % Timing stuff
% figure(1),plot(DATA(1:INDEX-2,1),'linewidth', 2.5)
% title('Time vs data point')
% figure(2),dt = DATA(2:end-2,1) - DATA(1:end-3,1);plot(dt,'linewidth', 1.5),grid
% title('Wait time by recorded data')
% figure(3),hold off,plot(DATA(:,11)-DATA(:,13),'linewidth', 1.5)
% title('Wait time by timing')
% axis([0,length(DATA),0,0.02]);
% hold on
% for i = 1:(INDEX-1)
%     if DATA(i,11)
%         plot(i, DATA(i,12), 'ro');
%     end
% end
% grid on
% hold off
% figure(4),hold off,plot(DATA(:,14),'linewidth', 1.5)
% title('Delta Time')
% axis([0,length(DATA),0,0.02]);
% figure(5),hold off,plot(DATA(:,15),'linewidth', 1.5)
% title('Data Rate - Delta Time')
% axis([0,length(DATA),0,0.02]);
% bad_plots


%% Save COMLOG
% This is for debugging the dropped packets from 4/8/18
save_COMLOG();
