function [up] = Projection_Capped_Cubic_Newton(u,k)

% min: 1/2 ||up - u||^2
% s.t. up^T1 <= k
%      0<= up <= 1    
% u is the vecoter that needs to prjected on a capped simplex
% k is part of the constaint


if sum(u) == k && all(u >= 0 & u <= 1)
    up = u;
else
    d = length(u);
    l0 =rand(1)+min(u(u~=0))-1;
    error = 100;
    idt = 0;
    while error > 1e-8
        tmp = u-l0;
        tmp(tmp>1) = 1;
        tmp(tmp<0) = 0;
        error = (k - sum(tmp));
        n = nnz(tmp);
        if n == 0
            fprintf("n==0, exit!")
            return;
        end
        idt = idt + 1;
        l1 = l0 - (error/n);
        error = abs(k - sum(tmp));
        l0 = l1;     
    end
    
    if l0 < 0
        l0 = 0;
    end
    
    tmp = u - l0;
    tmp(tmp>1) = 1;
    tmp(tmp<0) = 0;
    up = tmp;
    
end