function [  ] = update_input_buffer(  )
%UPDATE_INPUT_BUFFER Write whatevers stored on the serial port into the
%buffer
% Modeled after what's implemented in the arduino, since that works

config;

% If it's an unconnected simulation, just don't do it
if ~IS_CONNECTED
    return;
end

try
    if SERIAL_PORT.BytesAvailable
        temp = fread(SERIAL_PORT,SERIAL_PORT.BytesAvailable,'uint8')';

        i = length(temp) + BUFF_LENGTH;
        INPUT_BUFF = [ INPUT_BUFF(1:BUFF_LENGTH), temp+0, INPUT_BUFF(i+1:end) ];
        BUFF_LENGTH = BUFF_LENGTH + length(temp);
        
        COMLOG{COMDEX} = temp;
        COMDEX = COMDEX + 1;
    end
catch err
    fprintf('Exception on update_input_buffer\n');
    disp(err.stack)
end



end