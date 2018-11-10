function [ data_curr ] = parse_input_buffer(  )
%PARSE_INPUT_BUFFER Parses input buffer
%   The INPUT_BUFFER is a globally accessable array that contains the raw
%   bytes received from the XBee antenna. This function decodes those bytes
%   into the various floating point numbers and outputs them.


config;

data_curr = [];

% Read buffer
% update_input_buffer;

% Example data for not connected and ARM and FIRE are pressed
if (MODE > 0 && MODE < 5) && ~IS_CONNECTED
    data_curr = [START_TIME - t_0, 05, 00, 1+3*rand(), 4+1*rand(), 3+2*rand(), 4+.5*rand(), 5 + sin(toc)+.5*rand(),1,256];
end

% Empty Buffer
if (BUFF_LENGTH < 4), return; end

% Search for header
i = 1;
clri = 0;
row = 1;
while (i < BUFF_LENGTH)

    % Search for Data Header
    hashdr = false;
    while (i < BUFF_LENGTH)
        if prod(INPUT_BUFF(i:i+1) == hex_to_byte_array('0xAA 0x14'))
            i = i + 3;
            hashdr = true;
            break;
        end
        i = i + 1;
    end
    pcktlen = INPUT_BUFF(i-1); % Typecast is a potential error

    % If incomplete data packet, end the loop
    if ( (i + pcktlen - 1) > BUFF_LENGTH )
        break;
    end

    % Data lexicon
    if hashdr && i <= BUFF_LENGTH
        
        % Read packets
        if (INPUT_BUFF(i) == 1)
            % Nothing
        elseif (INPUT_BUFF(i) == 2)
            % Nothing
        elseif (INPUT_BUFF(i) == 16)
            ARDMODE = INPUT_BUFF(i+1);
        elseif (INPUT_BUFF(i) == 80) % Simulated packet 1
            data_curr(row,1) = toc - t_0; % time
            data_curr(row,2) = INPUT_BUFF(i+1); % mode
            data_curr(row,3) = INPUT_BUFF(i+2); % status
            data_curr(row,4) = INPUT_BUFF(i+3); % pressure_oxidizer
            data_curr(row,5) = INPUT_BUFF(i+4); % pressure_combustion
            data_curr(row,6) = INPUT_BUFF(i+5); % temperature_oxidizer
            data_curr(row,7) = INPUT_BUFF(i+6); % temperature_combustion
            data_curr(row,8) = INPUT_BUFF(i+7); % thrust
            data_curr(row,9) = INPUT_BUFF(i+8); % new data flag
            row = row + 1;
            RECORDED_DATA_VERSION = 80;
        elseif (INPUT_BUFF(i) == 64)
            % time
            a = bitshift(INPUT_BUFF(i+1), 24);
            b = bitshift(INPUT_BUFF(i+2), 16);
            c = bitshift(INPUT_BUFF(i+3), 8);
            d = bitshift(INPUT_BUFF(i+4), 0);
            data_curr(row,1) = bitor(bitor(bitor(a,b),c),d);
            
            % mode
            data_curr(row,2) = INPUT_BUFF(i+5);
            ARDMODE = data_curr(row,2);
            
            % error status
            a = cast(INPUT_BUFF(i+6),'uint16');
            b = cast(INPUT_BUFF(i+7),'uint16');
            data_curr(row,3) = cast(bitor(bitshift(a,8),b),'double');
            
            % temperature_combustion
            a = INPUT_BUFF(i+8);
            b = INPUT_BUFF(i+9);
            c = INPUT_BUFF(i+10);
            d = INPUT_BUFF(i+11);
            data_curr(row,4) = bytes_to_float(a,b,c,d);
            
            % thrust
            a = INPUT_BUFF(i+12);
            b = INPUT_BUFF(i+13);
            c = INPUT_BUFF(i+14);
            d = INPUT_BUFF(i+15);
            data_curr(row,5) = bytes_to_float(a,b,c,d);
            
            % new data flag
            data_curr(row,6) = INPUT_BUFF(i+16);
            
            % Checksum
            c = bitshift(INPUT_BUFF(i+17), 8);
            d = bitshift(INPUT_BUFF(i+18), 0);
            data_curr(row,7) = bitor(c,d);
            
            row = row + 1;
            RECORDED_DATA_VERSION = 64;
        elseif (INPUT_BUFF(i) == 81)
            % time
            a = bitshift(INPUT_BUFF(i+1), 24);
            b = bitshift(INPUT_BUFF(i+2), 16);
            c = bitshift(INPUT_BUFF(i+3), 8);
            d = bitshift(INPUT_BUFF(i+4), 0);
            data_curr(row,1) = bitor(bitor(bitor(a,b),c),d);
            
            % mode
            data_curr(row,2) = INPUT_BUFF(i+5);
            ARDMODE = data_curr(row,2);
            
            % error status
            a = cast(INPUT_BUFF(i+6),'uint16');
            b = cast(INPUT_BUFF(i+7),'uint16');
            data_curr(row,3) = cast(bitor(bitshift(a,8),b),'double');
            
            % pressure_oxidizer
            a = INPUT_BUFF(i+8);
            b = INPUT_BUFF(i+9);
            c = INPUT_BUFF(i+10);
            d = INPUT_BUFF(i+11);
            data_curr(row,4) = bytes_to_float(a,b,c,d);
            
            % pressure_combustion
            a = INPUT_BUFF(i+12);
            b = INPUT_BUFF(i+13);
            c = INPUT_BUFF(i+14);
            d = INPUT_BUFF(i+15);
            data_curr(row,5) = bytes_to_float(a,b,c,d);
            
            % temperature_oxidizer
            a = INPUT_BUFF(i+16);
            b = INPUT_BUFF(i+17);
            c = INPUT_BUFF(i+18);
            d = INPUT_BUFF(i+19);
            data_curr(row,6) = bytes_to_float(a,b,c,d);
            
            % temperature_combustion
            a = INPUT_BUFF(i+20);
            b = INPUT_BUFF(i+21);
            c = INPUT_BUFF(i+22);
            d = INPUT_BUFF(i+23);
            data_curr(row,7) = bytes_to_float(a,b,c,d);
            
            % thrust
            a = INPUT_BUFF(i+24);
            b = INPUT_BUFF(i+25);
            c = INPUT_BUFF(i+26);
            d = INPUT_BUFF(i+27);
            data_curr(row,8) = bytes_to_float(a,b,c,d);
            
            % new data flag
            data_curr(row,9) = INPUT_BUFF(i+28);
            
            % Checksum
            c = bitshift(INPUT_BUFF(i+29), 8);
            d = bitshift(INPUT_BUFF(i+30), 0);
            data_curr(row,10) = bitor(c,d);
            
            row = row + 1;
            RECORDED_DATA_VERSION = 81;
        elseif (INPUT_BUFF(i) == 82)
            % time
            a = bitshift(INPUT_BUFF(i+1), 24);
            b = bitshift(INPUT_BUFF(i+2), 16);
            c = bitshift(INPUT_BUFF(i+3), 8);
            d = bitshift(INPUT_BUFF(i+4), 0);
            data_curr(row,1) = bitor(bitor(bitor(a,b),c),d);
            
            % mode
            data_curr(row,2) = INPUT_BUFF(i+5);
            ARDMODE = data_curr(row,2);
            
            % error status
            a = cast(INPUT_BUFF(i+6),'uint16');
            b = cast(INPUT_BUFF(i+7),'uint16');
            data_curr(row,3) = cast(bitor(bitshift(a,8),b),'double');
            
            % pressure_oxidizer
            a = INPUT_BUFF(i+8);
            b = INPUT_BUFF(i+9);
            c = INPUT_BUFF(i+10);
            d = INPUT_BUFF(i+11);
            data_curr(row,4) = bytes_to_float(a,b,c,d);
            
            % pressure_combustion
            a = INPUT_BUFF(i+12);
            b = INPUT_BUFF(i+13);
            c = INPUT_BUFF(i+14);
            d = INPUT_BUFF(i+15);
            data_curr(row,5) = bytes_to_float(a,b,c,d);
            
            % temperature_oxidizer
            a = INPUT_BUFF(i+16);
            b = INPUT_BUFF(i+17);
            c = INPUT_BUFF(i+18);
            d = INPUT_BUFF(i+19);
            data_curr(row,6) = bytes_to_float(a,b,c,d);
            
            % temperature_combustion
            a = INPUT_BUFF(i+20);
            b = INPUT_BUFF(i+21);
            c = INPUT_BUFF(i+22);
            d = INPUT_BUFF(i+23);
            data_curr(row,7) = bytes_to_float(a,b,c,d);
            
            % temperature pre-combustion
            a = INPUT_BUFF(i+24);
            b = INPUT_BUFF(i+25);
            c = INPUT_BUFF(i+26);
            d = INPUT_BUFF(i+27);
            data_curr(row,8) = bytes_to_float(a,b,c,d);
            
            % thrust
            a = INPUT_BUFF(i+28);
            b = INPUT_BUFF(i+29);
            c = INPUT_BUFF(i+30);
            d = INPUT_BUFF(i+31);
            data_curr(row,9) = bytes_to_float(a,b,c,d);
            
            % new data flag
            data_curr(row,10) = INPUT_BUFF(i+32);
            
            % Checksum
            c = bitshift(INPUT_BUFF(i+33), 8);
            d = bitshift(INPUT_BUFF(i+34), 0);
            data_curr(row,11) = bitor(c,d);
            
            row = row + 1;
            RECORDED_DATA_VERSION = 82;
        else
            i= i - 1;
            continue;
        end
        
        i = i + pcktlen;
        clri = i;
    end
end

if (clri)
    clear_input_buffer(clri);
end

% disp('At end')
% disp(INPUT_BUFF(1:BUFF_LENGTH))

end

