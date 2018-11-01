function [  ] = initialize_plots( window_handle )
%INITIALIZE_PLOTS Initializes plots on the control window
% Sets the axis limits and sets hold on so that the plots will update
% quickly enough to keep up with a data rate of 100 Hz. This is required
% because MATLAB draws slowly.

config;

window_handle.pressureplot.XLim = [0, max_time];
window_handle.pressureplot.YLim = [min_P, max_P];
hold(window_handle.pressureplot, 'on');
grid(window_handle.pressureplot, 'on');
xlabel(window_handle.pressureplot, 'Time (sec)');
ylabel(window_handle.pressureplot, 'Pressure (psi)');
plot(window_handle.pressureplot, 0, 0, 'o','MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k');
plot(window_handle.pressureplot, 0, 0, 's','MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
legend(window_handle.pressureplot, 'Oxidizer Pressure', 'Combustion Chamber Pressure', 'AutoUpdate', 'off');


window_handle.temperatureplot.XLim = [0, max_time];
window_handle.temperatureplot.YLim = [min_T, max_T];
hold(window_handle.temperatureplot, 'on');
grid(window_handle.temperatureplot, 'on');
xlabel(window_handle.temperatureplot, 'Time (sec)');
ylabel(window_handle.temperatureplot, 'Temperature (F)');
plot(window_handle.temperatureplot, 0, 0, 'o','MarkerFaceColor', 'b', 'MarkerEdgeColor', 'k');
plot(window_handle.temperatureplot, 0, 0, 's','MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
legend(window_handle.temperatureplot, 'Precombustion Chamber Temp', 'Combustion Chamber Temp', 'AutoUpdate', 'off');


window_handle.thrustplot.XLim = [0, max_time];
window_handle.thrustplot.YLim = [min_Thr, max_Thr];
hold(window_handle.thrustplot, 'on');
grid(window_handle.thrustplot, 'on');
xlabel(window_handle.thrustplot, 'Time (sec)');
ylabel(window_handle.thrustplot, 'Thrust (Lbs)');


end

