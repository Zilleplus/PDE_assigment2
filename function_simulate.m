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
    x=linspace(0,1,h);y=linspace(0,1,h);
    u(1:end,1:end)=f_u_0(x(jx),y(jy));
    [x_mesh,y_mesh]=meshgrid(x,y);
    % set the border conditions
    t_0=0;

    u(2:end-1,1)   = fleft(t_0,y(jy(2:end-1,1))); % set the left border
    u(2:end-1,end) = fright(t_0,y(jy(2:end-1,end))); % set the left border

    u(1,:)     = fupper(t_0,x(jx(1,1:end))); % set the upper border
    u(end,:)   = flower(t_0,x(jx(end,1:end))); % set the lower border
    
    % exact solutions
    f_u_ex_heat = @(x,y,t) sin(pi.*x).*sin(pi.*y).*exp(-2*pi^2*t);
    f_u_ex_wave = @(x,y,t) sin(pi.*x).*sin(pi.*y).*(cos(sqrt(2).*pi.*t)+sin(sqrt(2).*pi.*t));%zeros(size(x));
    rect = @(x) (0<x & pi>x).*1;
    f_u_ex_transport = @(x,y,t) rect(pi.*x+pi.*t).*rect(pi.*y+pi.*t).*sin(pi.*x+pi.*t).*sin(pi.*y+pi.*t);%zeros(size(x));
    u_ex = zeros(h,h);
    
    uprevious=u; % needed with the wave equation
    uprevious=f_u_ex_wave(x_mesh,y_mesh,-dt);
    
    % plot the initial condition
    figure(figureNumber);clf;
%    subplot(3,2,1); surf(x,y,u); title(sprintf('t=%4.3f',0))
    subplot(3,1,1); surf(x,y,u); 
    if(strcmp(equation,'heat'))
        mu=dt/(dx^2); 
    elseif(strcmp(equation,'wave'))
        mu=dt^2/dx^2; 
    elseif(strcmp(equation,'transport'))
        mu=dt/dx;
    end
    title([sprintf('t = %4.3f',0) '  met  \mu ' sprintf('= %4.3f',mu)])
    j_int=j(2:end-1,2:end-1);
    for n = 1:k
        % Volgens mij is dit overbodig
%        u(2:end-1,1)   = fleft(t_0,y(jy(2:end-1,1))); % set the left border
%        u(2:end-1,end) = fright(t_0,y(jy(2:end-1,end))); % set the left border

%        u(1,:)     = fupper(t_0,x(jx(1,1:end))); % set the upper border
%        u(end,:)   = flower(t_0,x(jx(end,1:end))); % set the lower border
        
        if(strcmp(equation,'heat'))
            mu=dt/(dx^2); 
            u(2:end-1,2:end-1) = functin_integrate_heat( u,mu,h,j_int);
            u_ex = f_u_ex_heat(x_mesh,y_mesh,n*dt);           
        elseif(strcmp(equation,'wave'))
            mu=dt^2/dx^2; 
            [u(2:end-1,2:end-1),uprevious] = functin_integrate_wave( ...
                u,uprevious,mu,h,j_int);
            u_ex = f_u_ex_wave(x_mesh,y_mesh,n*dt);
        elseif(strcmp(equation,'transport'))
            mu=dt/dx;
            u(2:end-1,2:end-1) = functin_integrate_transport( u,mu,h,j_int);

            u_ex(2:end-1,2:end-1) = f_u_ex_transport(...
                x_mesh(2:end-1,2:end-1),y_mesh(2:end-1,2:end-1),n*dt);
        else
            disp('error invaid equation choice');
            return;
         end
%         if mod(n,k/5)==0
%             subplot(3,2,5*n/k+1); surf(x,y,u); title([sprintf('t=%4.3f',n*dt)...
%                 ' max. err. = ' num2str(max(max(abs(u-u_ex)))) ]);
%         end
%         if mod(n,k/2)==0
%             subplot(3,1,2*n/k+1); surf(x,y,u); title([sprintf('t = %4.3f',n*dt)...
%                 ' ' sprintf('max. err. = %4.3e',max(max(abs(u-u_ex))))]);
%         end
        if (n==k)
            subplot(3,1,3); surf(x,y,u); title([sprintf('t = %4.3f',n*dt)...
                ' ' sprintf('max. err. = %4.3e',max(max(abs(u-u_ex))))]);  
        elseif(n*dt<=0.1)
            subplot(3,1,2); surf(x,y,u); title([sprintf('t = %4.3f',n*dt)...
                ' ' sprintf('max. err. = %4.3e',max(max(abs(u-u_ex))))]);
        end
    end 
    disp(['mu=' num2str(mu)]);

end

