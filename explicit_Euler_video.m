clear all;% clf

% initializations
tf = 0.10;                  % time window length
h=20; dx = 1/h;             % number of points in x
k=300;dt = tf/k;           % number of timesteps
mu=dt/(dx^2);               % mu must be smaller then 1/4
if(mu<=0.25)
    disp(['mu:' num2str(mu) ' OK, this is STABLE'])
else
    disp(['mu:' num2str(mu) ' NOT OK, this might be UNSTABLE!'])
end
%%
% intial condition
f_u_0 =@(x,y) 0;
% border condition
fleft=  @(t,y)0;
fright= @(t,y)1;
fupper= @(t,x)0;
flower= @(t,x)1;

% create indices
[jx,jy] = meshgrid(1:h);
j=jy+(jx-1)*h;

% create initial grid
u=zeros(h,h);
u(2:end-1,2:end-1)=f_u_0(jx,jy); % set the inner points

% set the border conditions
t_0=0;

u(2:end-1,1)   = fleft(t_0,jy(2:end-1,1)); % set the left border
u(2:end-1,end) = fright(t_0,jy(2:end-1,end)); % set the left border

u(1,:)     = fupper(t_0,jx(1,1:end)); % set the upper border
u(end,:)   = flower(t_0,jx(end,1:end)); % set the lower border

% integrate in time and plot 5 solutions
unew=u; % preallocate this variable

figure('Renderer','zbuffer');

j_int=j(2:end-1,2:end-1);
x=linspace(1,0,h);
y=linspace(1,0,h);
%%
for n = 1:k
    u(2:end-1,1) = fleft(n*dt,jy(2:end-1,1)); % set the left border
    u(2:end-1,end) = fright(n*dt,jy(2:end-1,end)); % set the left border

    u(end,1:end) = fupper(n*dt,jx(1,1:end)); % set upper border
    u(1,1:end) = flower(n*dt,jx(end,1:end)); % set lower border
    
    u(2:end-1,2:end-1) = functin_integrate_heat( u,mu,h,j_int);
    
    surf(x,y,u); %axis([0 1 0 1 -1 1 -1 1]); 
    M(n)= getframe;
end 

writerObj = VideoWriter('movie_name.avi'); open(writerObj); 
writeVideo(writerObj,M); close(writerObj);