function [  ] = send_simulated_data(  )
%SEND_SIMULATED_DATA Summary of this function goes here
%   Detailed explanation goes here

config;

% Check if simulation is running
if MODE ~= 5
    return;
end

% Check that reached end of simulated data
if (SIM_DEX > length(SIM_DATA))
    MODE = 6;
    return;
end

% Lexicon
if (SIM_VER == 80) % 0x50
    hdr = hex_to_byte_array('0xAA 0x14 0x09 0x50');
    st = 0;
    po = SIM_DATA(SIM_DEX, 2);
    pc = SIM_DATA(SIM_DEX, 3);
    to = SIM_DATA(SIM_DEX, 4);
    tc = SIM_DATA(SIM_DEX, 5);
    th = SIM_DATA(SIM_DEX, 6);
    nd = 1;

    if IS_CONNECTED
        % Write to port
        fwrite(SERIAL_PORT, hdr, 'uint8'); pause(10/38400)
        fprintf('%d ',hdr)
        fwrite(SERIAL_PORT, MODE, 'uint8'); pause(10/38400)
        fprintf('%d ',MODE)
        fwrite(SERIAL_PORT, st, 'uint8'); pause(10/38400)
        fprintf('%d ',st)
        fwrite(SERIAL_PORT, po, 'uint8'); pause(10/38400)
        fprintf('%d ',po)
        fwrite(SERIAL_PORT, pc, 'uint8'); pause(10/38400)
        fprintf('%d ',pc)
        fwrite(SERIAL_PORT, to, 'uint8'); pause(10/38400)
        fprintf('%d ',to)
        fwrite(SERIAL_PORT, tc, 'uint8'); pause(10/38400)
        fprintf('%d ',tc)
        fwrite(SERIAL_PORT, th, 'uint8'); pause(10/38400)
        fprintf('%d ',th)
        fwrite(SERIAL_PORT, nd, 'uint8'); pause(10/38400)
        fprintf('%d\n',nd)
    else
        % Write to buffer
        i = BUFF_LENGTH+1;
        INPUT_BUFF(i:i+3) = hdr;
        INPUT_BUFF(i+04) = MODE;
        INPUT_BUFF(i+05) = st;
        INPUT_BUFF(i+06) = po;
        INPUT_BUFF(i+07) = pc;
        INPUT_BUFF(i+08) = to;
        INPUT_BUFF(i+09) = tc;
        INPUT_BUFF(i+10) = th;
        INPUT_BUFF(i+11) = nd;
        INPUT_BUFF(i+12) = 256;
        BUFF_LENGTH = BUFF_LENGTH + 13;
    end
end


SIM_DEX = SIM_DEX + 1;

end

