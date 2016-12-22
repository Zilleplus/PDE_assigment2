function [ error,dt,dx ] = part3_simulate_accuracy(equation, ...
    h,k,tf )

    f_u_0 =@(x,y) sin(pi.*x).*sin(pi.*y);
    % border condition
    fleft=  @(t,y)0;
    fright= @(t,y)0;
    fupper= @(t,x)0;
    flower= @(t,x)0;
    % initializations
    dx = 1/h;             % number of points in x
    dt = tf/k;           % number of timesteps
    
    % create indices
    [jx,jy] = meshgrid(1:h);
    j=jy+(jx-1)*h;

    % create initial grid
    u=zeros(h,h);
    error_all=zeros(k,1);
    x=linspace(0,1,h);y=linspace(0,1,h);

    u(1:end,1:end)=f_u_0(x(jx),y(jy));

    % set the border conditions
    t_0=0;

    u(2:end-1,1)   = fleft(t_0,y(jy(2:end-1,1))); % set the left border
    u(2:end-1,end) = fright(t_0,y(jy(2:end-1,end))); % set the left border

    u(1,:)     = fupper(t_0,x(jx(1,1:end))); % set the upper border
    u(end,:)   = flower(t_0,x(jx(end,1:end))); % set the lower border
    
    % exact solutions
    f_u_ex_heat = @(x,y,t) sin(pi.*x).*sin(pi.*y).*exp(-2*(pi^2)*t);
    f_u_ex_wave = @(x,y,t) sin(pi.*x).*sin(pi.*y).*(cos(sqrt(2).*pi.*t)+sin(sqrt(2).*pi.*t));%zeros(size(x));
    rect = @(x) (0<x & pi>x).*1;
    f_u_ex_transport = @(x,y,t) rect(pi.*x+pi.*t).*rect(pi.*y+pi.*t).*sin(pi.*x+pi.*t).*sin(pi.*y+pi.*t);%zeros(size(x));
    u_ex = f_u_0(x(jx),y(jy));
    
    uprevious=u; % needed with the wave equation
    uprevious=f_u_ex_wave(x(jx),y(jy),-dt);
    
    j_int=j(2:end-1,2:end-1);
    % integrate of t
    for n = 1:k         
        if(strcmp(equation,'heat'))
            mu=dt/(dx^2); 
            u(2:end-1,2:end-1) = functin_integrate_heat( u,mu,h,j_int);
            u_ex = f_u_ex_heat(x(jx),y(jy),n*dt);           
%            error_all(n)=max(max(abs(u-u_ex)));
            error_all(n)=norm(abs(u-u_ex),inf);
        elseif(strcmp(equation,'wave'))
            mu=dt^2/dx^2; 
            [u(2:end-1,2:end-1),uprevious] = functin_integrate_wave( ...
                u,uprevious,mu,h,j_int);

            u_ex = f_u_ex_wave(x(jx),y(jy),n*dt);
%            error_all(n)=max(max(abs(u-u_ex)));
            error_all(n)=norm(abs(u-u_ex),inf);
        elseif(strcmp(equation,'transport'))
            mu=dt/dx;
            u(2:end-1,2:end-1) = functin_integrate_transport( u,mu,h,j_int);
            u_ex(2:end-1,2:end-1) = f_u_ex_transport(...
                x(jx(2:end-1,2:end-1)),y(jy(2:end-1,2:end-1)),n*dt);
%            error_all(n)=max(max(abs(u-u_ex)));
            error_all(n)=norm(abs(u-u_ex),inf);
        else
            disp('error invaid equation choice');
            return;
        end
    end 
    disp(['mu=' num2str(mu) ' dt=' num2str(dt) ' dx=' num2str(dx)]);
    error = error_all(end); % van end een 1 maken voor error op eerste element
end