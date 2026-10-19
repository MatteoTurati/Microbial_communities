function [stable, feasible, x_eq, eig_J] = stability(r,A,gamma)

%STABILITY Evaluate feasibility and asymptotic stability of the coexistence equilibrium.
%   Computes the equilibrium, Jacobian eigenvalues, and corresponding
%   feasibility and stability conditions

B = A - diag(gamma);

x_eq = -B\r;
feasible = all(x_eq > 0);

J = diag(x_eq)*B;
eig_J = eig(J);
stable = all(real(eig_J) < 0);

disp('Equilibrium:')
disp(x_eq)

disp('Jacobian eigenvalues:')
disp(eig_J)

if feasible
    disp('The coexistence equilibrium is feasible')
else
    disp('The coexistence equilibrium is not feasible')
end

if stable
    disp('The coexistence equilibrium is asymptotically stable')
else
    disp('The coexistence equilibrium is not asymptotically stable.')
end

end