h=20; 
k=1000;
tf = 0.15;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)0;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)1;

figureNumber=1;
[ u ] = function_simulate( 'heat',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );

%%

h=10; 
k=100;
tf = 1;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)1;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=1;
[ u ] = function_simulate( 'wave',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );

%%

h=30; 
k=300;
tf = 2;% time window length

% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)1;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)0;

figureNumber=1;
[ u ] = function_simulate( 'transport',figureNumber , ... 
    h,k,tf,f_u_0,fleft,fright,fupper,flower );