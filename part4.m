% simulations part4
% TODO : bepaal h en k

%% heat
h=20;
k=2000;
figureNumber=1;
function_simulate_part4('heat',figureNumber,h,k);

fig=figure(figureNumber);saveas(fig,'./figures/part4_heat.png');
%% wave
h=20;
k=40;
figureNumber=2;
function_simulate_part4('wave',figureNumber,h,k);

fig=figure(figureNumber);saveas(fig,'./figures/part4_wave.png');
%% transport
h=20;
k=100;
figureNumber=3;
u =function_simulate_part4('transport',figureNumber,h,k);

fig=figure(figureNumber);saveas(fig,'./figures/part4_transport.png');