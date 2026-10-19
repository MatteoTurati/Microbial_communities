function dxdy = Ode_community(t,x,r,A,gamma)

%ODE_COMMUNITY Compute the dynamics of an n-species gLV community.
%   Simulates species growth from intrinsic growth rates, interspecies
%   interactions, and species-specific self-limitation.

n = length(x);

dxdy = zeros(n,1);

for i = 1:n

    interaction = 0;

    for j = 1:n

        if i ~= j
            interaction = interaction + A(i,j)*x(j);
        end

    end

    dxdy(i) = x(i)*(r(i) + interaction - gamma(i)*x(i));

end

end