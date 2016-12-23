clear all;clc;
load('part2_style.mat') % load style sheet

%% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2)); 
f_u_0 =@(x,y) (15.*(x-x.^2).*(y-y.^2).*exp(-50.*((x-0.5).^2+(y-0.5).^2)));
% border condition
fleft=  @(t,y)0;
fright= @(t,y) 0;
fupper= @(t,x)0;
flower= @(t,x) 0;

%% STABLE heat equation
h=30; 
k=900;
tf = 0.2;% time window length
mu=(tf/k)/((1/(h-1))^2);
if (mu<=0.25) 

figureNumber=1;
[ u ] = function_simulate_deel4( 'heat',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );

fig=figure(figureNumber);
setprinttemplate(fig,template);
print('./figures/part4_heat','-dpng');
else
    disp('Warmte stabiel: geen geldige h,k of tf')
end 

%% STABlE wave equation
h=30; 
k=10;
tf = 0.2;% time window length
mu=(tf/k)^2/((1/(h-1))^2);
if (mu<=0.5) 

figureNumber=2;
[ u ] = function_simulate_deel4( 'wave',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);
setprinttemplate(fig,template);
print('./figures/part4_wave','-dpng');
else
    disp('Golf stabiel: geen geldige h,k of tf')
end
%% STABLE transport equation

h=30; 
k=30;
tf = 0.2;% time window length
mu=(tf/k)/((1/(h-1)));
if (mu<=0.5) 
% intial condition
figureNumber=3;
[ u ] = function_simulate_deel4( 'transport',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);
setprinttemplate(fig,template); 
print('./figures/part4_transport','-dpng');
else
    disp('Transport stabiel: geen geldige h,k of tf')
end
