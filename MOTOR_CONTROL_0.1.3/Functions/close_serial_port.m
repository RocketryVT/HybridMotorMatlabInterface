%% Every now and then when I debug I forget to close the serial port
% I call this script before clearing the workspace so I can make sure the
% serial port is closed

config;

try
    fclose(SERIAL_PORT);
    pause(0.1);
    delete(SERIAL_PORT);
    fclose all
catch
    % Intentionally left blank
end

% try
%     fopen(SERIAL_PORT);
%     pause(0.1)
%     fclose(SERIAL_PORT);
% catch
%     try
%         fclose(SERIAL_PORT);
%     catch
%     end
% end
    