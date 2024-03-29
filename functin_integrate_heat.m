function [ unew ] = functin_integrate_heat( u,mu,h,j_int)
unew = (1-4.*mu).*u(j_int) + ... 
        mu.*( ...
            u(j_int+h) + u(j_int-h) + ...
            u(j_int+1) + u(j_int-1) ...
            );
end

