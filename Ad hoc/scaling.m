function X_scale = scaling(X)
S = cov(X);
Dw = diag(1./sqrt(diag(S)));
X_scale = Dw*demean(X)';
X_scale = X_scale';
end