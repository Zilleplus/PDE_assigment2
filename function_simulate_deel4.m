function [ u ] = function_simulate_deel4(equation,figureNumber, ...
    h,k,tf,f_u_0,fleft,fright,fupper,flower )
    % initializations
    dx = 1/(h-1);             % number of points in x
    dt = tf/k;           % number of timesteps
    
    % create indices
    [jx,jy] = meshgrid(1:h);
    j=jy+(jx-1)*h;

    % create initial grid
    u=zeros(h,h);
    x=linspace(0,1,h);y=linspace(0,1,h);
    u(1:end,1:end)=f_u_0(x(jx),y(jy));

    
    % set the border conditions
    t_0=0;

    u(2:end-1,1)   = fleft(t_0,y(jy(2:end-1,1))); % set the left border
    u(2:end-1,end) = fright(t_0,y(jy(2:end-1,end))); % set the left border

    u(1,:)     = fupper(t_0,x(jx(1,1:end))); % set the upper border
    u(end,:)   = flower(t_0,x(jx(end,1:end))); % set the lower border
    
    figure(10)
surf(x,y,u)
    
    uprevious=u; % needed with the wave equation
    
    % plot the initial condition
    figure(figureNumber);clf;

      
    j_int=j(2:end-1,2:end-1);
    for n = 1:k
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
        if (n*dt==0.1)
            title(['\mu ' sprintf('= %4.3f',mu)]) 
            subplot(2,1,1); surf(x,y,u); title(sprintf('t = %4.3f',n*dt));  
        elseif(n*dt==0.2)
            subplot(2,1,2); surf(x,y,u); title(sprintf('t = %4.3f',n*dt));
        end
    end 
    disp(['mu=' num2str(mu)]);
end

