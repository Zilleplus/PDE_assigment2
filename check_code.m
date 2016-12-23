%% STABLE heat equation
h=20; 
k=160.*50;
tf = 0.10.*50;% time window length
mu=(tf/k)/((1/h)^2);

% intial condition
%f_u_0 =@(x,y) zeros(size(x,1),size(x,2)); 
f_u_0 =@(x,y) 1;
% border condition
fleft=  @(t,y) 1;
fright= @(t,y) 1;
fupper= @(t,x) 1;
flower= @(t,x) 1;

figureNumber=1;
[ u ] = function_simulate( 'heat',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );