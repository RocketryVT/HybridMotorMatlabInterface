%% Simulation Test data with simple, 1 byte numbers

clear, clc

t = 0:0.01:30;

ch1 = 1*ones(size(t));
ch2 = 2*ones(size(t));
ch3 = 3*ones(size(t));
ch4 = 4*ones(size(t));
ch5 = 5*ones(size(t));
ch6 = 6*ones(size(t));

data = [ t; ch1; ch2; ch3; ch4; ch5; ch6 ]';
simdatver = hex_to_byte_array('0x50');

save SimulatedData/sim_data_1.mat simdatver data

clear, clc

load SimulatedData/sim_data_1.mat

plot(data(:,1), data(:,2:end))