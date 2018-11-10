function [ j ] = update_plots( handles, j )
%UPDATE_PLOTS Updates data and plots on the control window
% Updates the control window text boxes and plots with the given data.
% Plots are only updated if the Arduino is in the FIRE state, text boxes
% are always updated so the user can tell what values they are to start
% with.
%
% INPUTS
% handles -> handle, handle to the control window
% data_curr -> 1x9 array, current block of data
% j -> int, index of the last plotted point
%
% OUTPUTS
% j -> int, the index of the last plotted point

t_plot = toc;
config;

% Update text boxes
if INDEX > 1 && MODE ~= 4 && MODE ~= 6
    time = 0;
    p_o  = 0;
    p_c  = 0;
    t_o  = 0;
    t_c  = 0;
    tpc  = 0;
    thr  = 0;
    
    
    % Access current data point
    i = INDEX;
    if (~DATA(INDEX,1))
        i = i - 1;
    end
    if (RECORDED_DATA_VERSION == 81)
        time = (DATA(i,1) - t_0)*1e-6;
        p_o  = DATA(i,4);
        p_c  = DATA(i,5);
        t_o  = DATA(i,6);
        t_c  = DATA(i,7);
        thr  = DATA(i,8);
    elseif (RECORDED_DATA_VERSION == 82)
        time = (DATA(i,1) - t_0)*1e-6;
        p_o  = DATA(i,4);
        p_c  = DATA(i,5);
        t_o  = DATA(i,6);
        t_c  = DATA(i,7);
        tpc  = DATA(i,8);
        thr  = DATA(i,9);
    elseif (RECORDED_DATA_VERSION == 64)
        time = (DATA(i,1) - t_0)*1e-6;
        t_c  = DATA(i,4);
        thr  = DATA(i,5);
        p_o  = NaN;
        p_c  = NaN;
        t_o  = NaN;
        tpc  = NaN;
    end
    

    % Update Text Boxes
    handles.pressureoxidizertext.String = num2str(p_o);
    handles.pressurecombustiontext.String = num2str(p_c);
    handles.temperatureoxidizertext.String = num2str(t_o);
    handles.temperaturecombustiontext.String = num2str(t_c);
    handles.temperaturepostcombustion.String = num2str(tpc);
    handles.thrusttext.String = num2str(thr);
end

if (IS_PLOTTING && (MODE == 2 || MODE == 5))
    
    p_o  = zeros(INDEX-j+1,8);
    p_c  = zeros(INDEX-j+1,8);
    t_o  = zeros(INDEX-j+1,8);
    t_c  = zeros(INDEX-j+1,8);
    tpc  = zeros(INDEX-j+1,8);
    thr  = zeros(INDEX-j+1,8);
    
    % Access latest point of data
    if (RECORDED_DATA_VERSION == 81)
        time = (DATA(j:INDEX,1) - t_0)/1e6;
        p_o  = DATA(j:INDEX,4);
        p_c  = DATA(j:INDEX,5);
        t_o  = DATA(j:INDEX,6);
        t_c  = DATA(j:INDEX,7);
        thr  = DATA(j:INDEX,8);
        tpc  = zeros(INDEX-j+1,8);
    elseif (RECORDED_DATA_VERSION == 82)
        time = (DATA(j:INDEX,1) - t_0)/1e6;
        p_o  = DATA(j:INDEX,4);
        p_c  = DATA(j:INDEX,5);
        t_o  = DATA(j:INDEX,6);
        t_c  = DATA(j:INDEX,7);
        tpc  = DATA(j:INDEX,8);
        thr  = DATA(j:INDEX,9);
    elseif (RECORDED_DATA_VERSION == 64)
        time = (DATA(j:INDEX,1) - t_0)/1e6;
        p_o  = NaN;
        p_c  = NaN;
        t_o  = NaN;
        t_c  = DATA(j:INDEX,4);
        tpc  = NaN;
        thr  = DATA(j:INDEX,5);
    end

    % Plot data, as long as you (probably) have enough time to plot
    if (toc - t_plot + data_rate*plot_timebuff < data_rate)
        plot(handles.pressureplot, time, p_o, 'o','MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k');
        plot(handles.pressureplot, time, p_c, 's', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
    end
    update_input_buffer();
    if (toc - t_plot + data_rate*plot_timebuff < data_rate)
        plot(handles.temperatureplot, time, t_o, 'o','MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k');
        plot(handles.temperatureplot, time, t_c, 's', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
        plot(handles.temperatureplot, time, tpc, '*', 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'k');
    end
    update_input_buffer();
    if (toc - t_plot + data_rate*plot_timebuff < data_rate)
        plot(handles.thrustplot, time, thr, '*','MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k');
        
        j = INDEX; % If everything gets plotted, update the last unplotted point
    end
    update_input_buffer();
end
end

