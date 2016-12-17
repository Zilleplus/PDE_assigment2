clear all;% clf

% initializations
tf = 0.15;                  % time window length
h=20; dx = 1/h;             % number of points in x
k=1000;dt = tf/k;           % number of timesteps
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

% plot the initial condition
figure(1);clf;
subplot(3,2,1); surf(u); title(sprintf('t=%4.3f',0))

% integrate in time and plot 5 solutions
unew=u; % preallocate this variable

j_int=j(2:end-1,2:end-1);
%%
for n = 1:k
    u(2:end-1,1) = fleft(n*dt,jy(2:end-1,1)); % set the left border
    u(2:end-1,end) = fright(n*dt,jy(2:end-1,end)); % set the left border

    u(end,1:end) = fupper(n*dt,jx(1,1:end)); % set upper border
    u(1,1:end) = flower(n*dt,jx(end,1:end)); % set lower border
    
    u(2:end-1,2:end-1) = functin_integrate_heat( u,mu,h,j_int);
    
    if mod(n,k/5)==0
        subplot(3,2,5*n/k+1); surf(u); title(sprintf('t=%4.3f',n*dt));        
    end
end 