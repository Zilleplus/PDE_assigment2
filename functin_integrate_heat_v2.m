function [ unew ] = functin_integrate_heat_v2( u,mu,h,j_int)
unew = (1-4.*mu).*u(j_int) + ... 
        mu.*u(j_int+h) + mu.* u(j_int-h) + ...
            mu.*u(j_int+1) + mu.*u(j_int-1);
end