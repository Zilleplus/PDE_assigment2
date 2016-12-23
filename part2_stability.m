clear all;clc;
load('part2_style.mat') % load style sheet

%% STABLE heat equation
h=20; 
k=160.*30;
tf = 0.10.*30;% time window length

mu=(tf/k)/((1/(h-1))^2);
if (mu<=0.25) 
% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2)); 
f_u_0 =@(x,y) sin(pi.*x).*sin(pi.*y);
% border condition
fleft=  @(t,y)0;
fright= @(t,y) 0;
fupper= @(t,x)0;
flower= @(t,x) 0;

figureNumber=1;
[ u ] = function_simulate( 'heat',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );

fig=figure(figureNumber);
setprinttemplate(fig,template);
print('./figures/part2_stable_heat','-dpng');
else
    disp('Warmte stabiel: geen geldige h,k of tf')
end 
%% UNSTABLE heat equation
h=20; 
k=140.*30;
tf = 0.1.*30;% time window length
mu=(tf/k)/((1/(h-1))^2);
if (mu>.25) 
% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2));
f_u_0 =@(x,y) sin(pi.*x).*sin(pi.*y);
% border condition
fleft=  @(t,y)0;
fright= @(t,y)0;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=2;
[ u ] = function_simulate( 'heat',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );

fig=figure(figureNumber); 
setprinttemplate(fig,template);
print('./figures/part2_unstable_heat','-dpng');
else
    disp('Warmte onstabiel: geen geldige h,k of tf')
end
%% STABlE wave equation
h=20; 
k=85;
tf = 3;% time window length
mu=(tf/k)^2/((1/(h-1))^2);
if (mu<=0.5) 
% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2));
f_u_0 =@(x,y) sin(pi.*x).*sin(pi.*y);
% border condition
fleft=  @(t,y)0;
fright= @(t,y)0;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=3;
[ u ] = function_simulate( 'wave',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);
setprinttemplate(fig,template);
print('./figures/part2_stable_wave','-dpng');
else
    disp('Golf stabiel: geen geldige h,k of tf')
end
%% UNSTABLE wave equation
h=20; 
k=76;
tf = 3;% time window length
mu=(tf/k)^2/((1/(h-1))^2);
if (mu>0.5) 
% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2));
f_u_0 =@(x,y) sin(pi.*x).*sin(pi.*y);
% border condition
fleft=  @(t,y)0;
fright= @(t,y)0;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=4;
[ u ] = function_simulate( 'wave',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);
setprinttemplate(fig,template); 
print('./figures/part2_unstable_wave','-dpng');
else
    disp('Golf onstabiel: geen geldige h,k of tf')
end
%% STABLE transport equation

h=20; 
k=40;
tf = 1;% time window length
mu=(tf/k)/((1/(h-1)));
if (mu<=0.5) 
% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2));
f_u_0 =@(x,y) sin(pi.*x).*sin(pi.*y);
% border condition
fleft=  @(t,y)0;
fright= @(t,y)0;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=5;
[ u ] = function_simulate( 'transport',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber);
setprinttemplate(fig,template); 
print('./figures/part2_stable_transport','-dpng');
else
    disp('Transport stabiel: geen geldige h,k of tf')
end
%% UNSTABLE transport equation
h=20; 
k=32;
tf = 1;% time window length
mu=(tf/k)/((1/(h-1)));
if (mu>0.5) 
% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2));
f_u_0 =@(x,y) sin(pi.*x).*sin(pi.*y);
% border condition
fleft=  @(t,y)0;
fright= @(t,y)0;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=6;
[ u ] = function_simulate( 'transport',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );
fig=figure(figureNumber); 
setprinttemplate(fig,template); 
print('./figures/part2_unstable_transport','-dpng');
else
    disp('Transport onstabiel: geen geldige h,k of tf')
end