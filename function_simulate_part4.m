function [ u ] = function_simulate_part4(equation,figureNumber,h,k)
    % initializations
    tf = 1;% time window length

    % intial condition
%     f_u_0 =@(x,y) ones(size(x,1),size(x,2));
    f_u_0 =@(x,y) 15.*(x-x.^2).*(y-y.^2).* ...
        exp( -50.*( (x-0.5).^2  + (y-0.5).^2 ) );
    % border condition
    fleft=  @(t,y)1;
    fright= @(t,y)1;
    fupper= @(t,x)0;
    flower= @(t,x)0;
    
    dx = 1/h;             % number of points in x
    dt = tf/k;           % number of timesteps
    
    % create indices
    [jx,jy] = meshgrid(1:h);
    j=jy+(jx-1)*h;

    % create initial grid
    u=f_u_0(jx,jy); % set the inner points

    % set the border conditions
    t_0=0;

    u(2:end-1,1)   = fleft(t_0,jy(2:end-1,1)); % set the left border
    u(2:end-1,end) = fright(t_0,jy(2:end-1,end)); % set the left border

    u(1,:)     = fupper(t_0,jx(1,1:end)); % set the upper border
    u(end,:)   = flower(t_0,jx(end,1:end)); % set the lower border
    
    uprevious=u; % needed with the wave equation

    index_plot=1;
    j_int=j(2:end-1,2:end-1);
    figure(figureNumber);clf;
    for n = 1:k
        u(2:end-1,1) = fleft(n*dt,jy(2:end-1,1)); % set the left border
        u(2:end-1,end) = fright(n*dt,jy(2:end-1,end)); % set the left border

        u(1,:) = fupper(n*dt,jx(1,1:end)); % set upper border
        u(end,:) = flower(n*dt,jx(end,1:end)); % set lower border
        
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
        if n*dt==0.1 || n*dt==0.2 
            subplot(1,2,index_plot); surf(u); title(sprintf('t=%4.3f',n*dt));  
            index_plot=index_plot+1;
        end
    end 
    disp([equation 'mu= ' num2str(mu)]);
end

