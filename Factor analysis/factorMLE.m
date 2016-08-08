function [A , sigma2, mu, loglik] = factorMLE(Dat,k)


[n ,d] = size(Dat);
[ coeff, ~, eig] = pca(Dat);
sigma2 = (sum(eig)-sum(eig(1:k)))/(d-k);

Gammak = coeff(:, 1:k);
Lambdak = diag(eig(1:k));
A = Gammak*(Lambdak- sigma2*eye(k))^(1/2);
%if k>1 && k < 4
%biplot(A);
%end

mu = mean(Dat, 1);
Sigma = A*A'+sigma2*eye(d);
S = cov(Dat);
MLEsigma = ((n-1)/n)*S;



lik = (det(Sigma)/det(MLEsigma))^(-n/2)*exp(n*d/2-(n-1)/2*trace(inv(Sigma)*S));
loglik = -2*log(lik);
nu = 1/2*((d-k)^2-(d+k))
1-chi2cdf(log_test, nu)
end