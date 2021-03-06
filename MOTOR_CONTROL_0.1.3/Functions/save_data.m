function [  ] = save_data( file )
%SAVE_DATA Saves data from DATA to a file
%
% INPUTS
% file -> string, path and file to save data to
% 
% OUTPUTS
% 

config;

if ~RECORDED_DATA_VERSION
    return;
end

ISSAVED = true;
fid = fopen(file,'w');

INDEX = INDEX - 1; % It keeps printing an uninitialized row at the end

% Write current data to file from DATA
switch RECORDED_DATA_VERSION
    case 11 % Data Packet v1
        fprintf(fid, ...
        'Time,Mode,Status,Pressure_O,Pressure_C,Temperature_O,Temperature_C,Thrust,New_Data,Checksum\n');
        for i = 1:INDEX
            fprintf(fid, '%.5f', DATA(i,1)*1e-6);
            for j = 2:10
                fprintf(fid, ',%.5f', DATA(i,j));
            end
            fprintf(fid, '\n');
        end
    
    case 80 % Simulated Data 1
        fprintf(fid, ...
        'Time,Mode,Status,Pressure_O,Pressure_C,Temperature_O,Temperature_C,Thrust,New_Data,Checksum\n');
        for i = 1:INDEX
            fprintf(fid, '%.5f', DATA(i,1)*1e-6);
            for j = 2:10
                fprintf(fid, ',%.5f', DATA(i,j));
            end
            fprintf(fid, '\n');
        end
    case 64 % Solid Static Fire
        fprintf(fid, ...
        'Time,Mode,Status,Temperature_C,LoadCell,New_Data,Checksum\n');
        for i = 1:INDEX
            fprintf(fid, '%d', DATA(i,1)*1e-6);
            fprintf(fid, ',%d', DATA(i,2));
            fprintf(fid, ',%d', DATA(i,3));
            for j = 4:5
                fprintf(fid, ',%.8f', DATA(i,j));
            end
            fprintf(fid, ',%d', DATA(i,6)); % Status
            fprintf(fid, ',%d', DATA(i,7)); % Checksum
            fprintf(fid, '\n');
        end
    case 81 % Cold Flow Testing Data 2
        fprintf(fid, ...
        'Time,Mode,Status,Pressure_O,Pressure_C,Temperature_O,Temperature_C,Thrust,New_Data,Checksum\n');
        for i = 1:INDEX
            fprintf(fid, '%d', DATA(i,1)*1e-6);
            fprintf(fid, ',%d', DATA(i,2));
            fprintf(fid, ',%d', DATA(i,3));
            for j = 4:10
                fprintf(fid, ',%.8f', DATA(i,j));
            end
            fprintf(fid, ',%d', DATA(i,9)); % Status
            fprintf(fid, ',%d', DATA(i,10)); % Checksum
            fprintf(fid, '\n');
        end
    case 82 % Cold Flow Testing Data 2
        fprintf(fid, ...
        'Time,Mode,Status,Pressure_O,Pressure_C,Temperature_O,Temperature_C,Temperature_Post-C,Thrust,New_Data,Checksum\n');
        for i = 1:INDEX
            fprintf(fid, '%d', DATA(i,1)*1e-6);
            fprintf(fid, ',%d', DATA(i,2));
            fprintf(fid, ',%d', DATA(i,3));
            for j = 4:11
                fprintf(fid, ',%.8f', DATA(i,j));
            end
            fprintf(fid, ',%d', DATA(i,10)); % Status
            fprintf(fid, ',%d', DATA(i,11)); % Checksum
            fprintf(fid, '\n');
        end
end

% If .mat
fclose(fid);
end

