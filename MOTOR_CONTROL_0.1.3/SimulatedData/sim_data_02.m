%% Simulation Test data with simple, 1 byte numbers that are sinusoidal

clear, clc

t = 0:0.01:30;

po = round(4*sin(20*t) + 5.5);
pc = round(4*cos(15*t-pi) + 4.5);
to = round(4*sin(12*t) + 5.5);
tc = round(4*sin(15*t) + 4.5);
th = round(4.5*sin(12*t) + 5);

data = [ t; po; pc; to; tc; th ]';
simdatver = hex_to_byte_array('0x50');

save SimulatedData/sim_data_2.mat simdatver data

clear, clc

load SimulatedData/sim_data_2.mat

plot(data(:,1), data(:,2:end))