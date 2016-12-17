function [ u ] = function_simulate(equation,figureNumber, ...
    h,k,tf,f_u_0,fleft,fright,fupper,flower )
    % initializations
    
    dx = 1/h;             % number of points in x
    dt = tf/k;           % number of timesteps
    
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
    
    uprevious=u; % needed with the wave equation

    % plot the initial condition
    figure(figureNumber);clf;
    subplot(3,2,1); surf(u); title(sprintf('t=%4.3f',0))

    j_int=j(2:end-1,2:end-1);
    for n = 1:k
        u(2:end-1,1) = fleft(n*dt,jy(2:end-1,1)); % set the left border
        u(2:end-1,end) = fright(n*dt,jy(2:end-1,end)); % set the left border

        u(end,1:end) = fupper(n*dt,jx(1,1:end)); % set upper border
        u(1,1:end) = flower(n*dt,jx(end,1:end)); % set lower border
        
        if(strcmp(equation,'heat'))
            mu=dt/(dx^2); 
            u(2:end-1,2:end-1) = functin_integrate_heat( u,mu,h,j_int);
        elseif(strcmp(equation,'wave'))
            mu=dt^2/dx^2; 
            [u(2:end-1,2:end-1),uprevious] = functin_integrate_wave( ...
                u,uprevious,mu,h,j_int);
        elseif(strcmp(equation,'transport'))
            mu=dt/dx;
            u(2:end-1,2:end-1) = functin_integrate_transport( u,mu,h,j_int);
        else
            disp('error invaid equation choice');
            return;
        end
        if mod(n,k/5)==0
            subplot(3,2,5*n/k+1); surf(u); title(sprintf('t=%4.3f',n*dt));        
        end
    end 
    disp(['mu=' num2str(mu)]);

end

