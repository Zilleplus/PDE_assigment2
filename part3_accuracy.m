% increase/decrese h and k while keeping mu constant
% dx = 1/h             % number of points in x
% dt = tf/k
clc;clear all;
%%

% An accuracy of order O(delta t , delta x ^2)
clc;
h=10;
k=40;
tf=0.1;

steps=4;
error_heat = zeros(3,steps);
for i=1:steps
    [error_heat(1,i), error_heat(2,i), error_heat(3,i)] = part3_simulate_accuracy('heat',h,k,tf );
    h=h*2;
    k=k*4;
end
rowLabels = {'error', 'dt', 'dx'};
matrix2latex(error_heat, './tables/orde_test_heat.tex', ... 
    'rowLabels', rowLabels,  ...
    'alignment', 'c', ...
    'format', '%-6.2e');

disp(error_heat);
%% EXPERIMENTAL TABLE, what happens if dt is insanely large?
clc;
h=100;
k=40;
steps=4;

tf=0.0000001;

for i=1:steps
    [error_heat(1,i), error_heat(2,i), error_heat(3,i)]  = part3_simulate_accuracy('heat',h,k,tf );
    h=h*2;
    k=k*4;
end

% dx = 1/h;             % number of points in x
% dt = tf/k;           % number of timesteps

%%

% wave
h=10*2; 
k=25*2;
tf = 1;% time window length
% error = part3_simulate_accuracy('wave',h,k,tf )

steps=4;
error_wave = zeros(3,steps);
% generate table
for i=1:steps
    dx(i) = 1/h;             % number of points in x
    dt(i) = tf/k;
    [error_wave(1,i), error_wave(2,i), error_wave(3,i)]  = part3_simulate_accuracy('wave',h,k,tf );
    h=h*2;
    k=k*2;
end
disp(error_wave);
rowLabels = {'error', 'dt', 'dx'};
matrix2latex(error_wave, './tables/orde_test_wave.tex', ... 
    'rowLabels', rowLabels,  ...
    'alignment', 'c', ...
    'format', '%-6.2e');

disp(error_transport);

%%
% transport

clc;clear all;
h=50; 
k=30;
tf = 0.1;% time window length

steps=3;
error_transport = zeros(3,steps);
% generate table
for i=1:steps
    [error_transport(1,i), error_transport(2,i), error_transport(3,i)] = part3_simulate_accuracy('transport',h,k,tf );
    h=h*2;
    k=k*2;
end
rowLabels = {'error', 'dt', 'dx'};
matrix2latex(error_transport, './tables/orde_test_transport.tex', ... 
    'rowLabels', rowLabels,  ...
    'alignment', 'c', ...
    'format', '%-6.2e');

disp(error_transport);