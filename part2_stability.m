%% STABLE heat equation
h=20; 
k=160;
tf = 0.1;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)0;
fright= @(t,y) 1;
fupper= @(t,x)0;
flower= @(t,x) 1;

figureNumber=1;
[ u ] = function_simulate( 'heat',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );

fig=figure(figureNumber);saveas(fig,'./figures/part2_stable_heat.png');
%% UNSTABLE heat equation
h=20; 
k=150;
tf = 0.1;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)0;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)1;

figureNumber=2;
[ u ] = function_simulate( 'heat',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );

fig=figure(figureNumber);saveas(fig,'./figures/part2_unstable_heat.png');
%% STABlE wave equation
h=20; 
k=40;
tf = 1;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)1;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=3;
[ u ] = function_simulate( 'wave',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);saveas(fig,'./figures/part2_stable_wave.png');

%% UNSTABLE wave equation
h=20; 
k=25;
tf = 1;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)1;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=4;
[ u ] = function_simulate( 'wave',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);saveas(fig,'./figures/part2_unstable_wave.png');

%% STABLE transport equation

h=20; 
k=80;
tf = 2;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)1;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=5;
[ u ] = function_simulate( 'transport',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);saveas(fig,'./figures/part2_stable_transport.png');
%% UNSTABLE transport equation
h=20; 
k=65;
tf = 2;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)1;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=6;
[ u ] = function_simulate( 'transport',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);saveas(fig,'./figures/part2_unstable_transport.png');