%  example code: explicit Euler for the 1D diffusion equation
%  with x in [0,1] and t in [0,tf]

clear all; clf

% initializations
  tf = 0.02;                  % time window length
  nx = 50; dx = 1/nx;         % number of points in x
  nt = 1000; dt = tf/nt;      % number of timesteps
  
  x = linspace(0,1,nx+1);     % x-point coordinates
  u = sin(20*pi*x.^2.*(1-x)); % initial condition (MATLAB syntax!)
  f1= @(t)0;                  % lhs Dirichlet condition
  f2= @(t)0;                  % rhs Dirichlet condition
  mu = dt/(dx*dx); 
  j = 2:nx;                   % indices of interior points:2..nx
                              % leftmost point has index 1
                              % rightmost point has index nx+1

% plot the initial condition

  subplot(3,2,1); plot(x,u); title(sprintf('t=%4.3f',0))

% integrate in time and plot 5 solutions

  for n = 1:nt
    u(1) = f1(n*dt); u(nx+1) = f2(n*dt);
    u(j) = mu*u(j-1) + (1-2*mu)*u(j) + mu*u(j+1);   
    if mod(n,nt/5)==0
          subplot(3,2,5*n/nt+1); plot(x,u); title(sprintf('t=%4.3f',n*dt))
    end
  end
  