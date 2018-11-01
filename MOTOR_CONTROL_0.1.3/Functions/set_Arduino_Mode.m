function [ ] = set_Arduino_Mode( mode )
%SET_ARDUINO_MODE Sends command to set the Arduino mode
%   Outputs the command over the serial port to the Arduino to change the
%   mode
%
% INPUTS
% mode -> Set the mode to this

config

if mode > 255 || mode < 0
    return;
end

fwrite(SERIAL_PORT, hex_to_byte_array('0xAA 0x14 0x02 0x04'), 'uint8');
fwrite(SERIAL_PORT, mode, 'uint8');

end

