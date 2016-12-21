% increase/decrese h and k while keeping mu constant
% dx = 1/h             % number of points in x
% dt = tf/k
clc;clear all;
%%

% An accuracy of order 2 should be observed
clc;
h=10; 
k=40;
tf = 0.1;% time window length

for i=1:5
    [ error_heat(i) ] = part3_simulate_accuracy('heat',h,k,tf );
    h=2*h;
    k=4*k;
    
end

%%

% wave
h=10; 
k=25;
tf = 1;% time window length
% error = part3_simulate_accuracy('wave',h,k,tf )

for i=1:5
    [ error_wave(i) ] = part3_simulate_accuracy('wave',h,k,tf );
    h=h*2;
    k=k*2;
end
disp(error_wave);

%%
% transport

clc;clear all;
h=10; 
k=15;
tf = 1;% time window length

for i=1:9
    [ error ] = part3_simulate_accuracy('wave',h,k,tf )
    h=h*2;
    k=k*2;
end