function [  ] = save_COMLOG(  )
%SAVE_COMLOG A log of the raw bytes recorded during the test is recorded
% This function saves the raw bytes for decoding later

config;

% If debug mode is not on, don't save
if ~savedump
    return;
end

if savedump
    % File Name
    test_date = datestr(datetime);
    for i = 1:length(test_date)
        if strcmp(test_date(i),':')
            test_date(i) = '-';
        end
        if strcmp(test_date(i),' ')
            test_date(i) = '-';
        end
    end
    file = (strcat('Data\R@VT_Populsion-', test_date, '-COMLOG.txt'));

    % Save
    fid = fopen(file,'w');
    for i = 1:COMDEX
        arr = COMLOG{i};
        if isempty(arr)
            continue;
        end
        fprintf(fid, '%.2X', arr(1));
        for j = 2:length(arr)
            fprintf(fid, ' %.2X', arr(j));
        end
        fprintf(fid, '\n');
    end
    fclose(fid);
end

end

