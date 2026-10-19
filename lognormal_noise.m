function Xpert = lognormal_noise(X, CV, dim)

%LOGNORMAL_NOISE Generate lognormally perturbed versions of X.
%   Xpert = LOGNORMAL_NOISE(X, CV, dim) applies multiplicative lognormal
%   noise with coefficient of variation CV to X, generating dim realizations.

sigma2 = log(1 + CV.^2);
sigma = sqrt(sigma2);
eps = randn(dim, length(X));

Xpert = X .* exp(eps .* sigma - 0.5 .* sigma2);

end