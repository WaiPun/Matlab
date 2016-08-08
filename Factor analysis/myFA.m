
function [A_pca, A_mle, A_ppca] = myFA(Dat,k)
A_mle = 0;
A_ppca = 0;
S = cov(Dat);
[n,d] = size(Dat);

%%%%%%%%%%%%%%%%%%%%%%%
% PCA
%%%%%%%%%%%%%%%%%%%%%%%
[coeff, ~, latent] = pca(Dat);
Gammak = coeff(:,1:k);
latentk = diag(latent(1:k));
A_pca = Gammak*latentk^(1/2);
Psi_pca = diag(diag(S))-diag(diag(Gammak*latentk*Gammak'));
F_pca = latentk^(-1/2)*Gammak'*(demean(Dat)');
F_pca = F_pca';
if k==1
    hist(F_pca)
else
    plotmatrix(F_pca)
    title('Factor scores plot');
end

if k==2 || k==3
    figure
    subplot(3,1,1)
    biplot(A_pca);
    title('Unrotated using PCA');
    subplot(3,1,2)
    biplot(rotatefactors(A_pca));
    title('Orthogonal rotation using PCA');
    subplot(3,1,3)
    biplot(rotatefactors(A_pca,'Method', 'promax'))
    title('Olique rotation using PCA');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Provided that the degree of freedom is greater than 1.
if d*(d+1)/2-(d*k+k-k*(k-1)/2)>1
[A, Psi, T, stats, F] = factoran(Dat, k);
if k==2 || k==3
    figure
    subplot(3,1,1)
    biplot(A);
    title('Unrotated using ML');
    subplot(3,1,2)
    biplot(rotatefactors(A));
    title('Orthogonal rotation using ML');
    subplot(3,1,3)
    biplot(rotatefactors(A,'Method', 'promax'))
    title('Olique rotation using ML');
end
figure
if k==1
    hist(F)
else
    plotmatrix(F)
    title('Factor scores plot using MLE');
end
A_mle = A;
% Display MLE results
sprintf('Null Hypothesis: %d - factors model using MLE is sufficient. \n Log-likelihood ratio %d with degrees of freedom %d \n p-value is %d', k, stats.chisq, stats.dfe, stats.p)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PPCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%
[coeff, ~, latent] = pca(Dat);
sigma2 = (sum(latent)-sum(latent(1:k)))/(d-k);

Gammak = coeff(:, 1:k);
Lambdak = diag(latent(1:k));
A_ppca = Gammak*(Lambdak- sigma2*eye(k))^(1/2);

if k==2 || k==3
    figure
    subplot(3,1,1)
    biplot(A_ppca);
    title('Unrotated using PPCA');
    subplot(3,1,2)
    biplot(rotatefactors(A_ppca));
    title('Orthogonal rotation using PPCA');
    subplot(3,1,3)
    biplot(rotatefactors(A_ppca,'Method', 'promax'))
    title('Olique rotation using PPCA');
end

% Hypothesis testing
% provided nu>1
if d*(d+1)/2-(d*k+1-k*(k-1)/2)>1
V = A_ppca*A_ppca'+sigma2*eye(d);
Sigma = (n-1)/n*S;
log_test = -2*log(((det(V)/det(Sigma)))^(-n/2)*exp(n*d/2-(n-1)/2*trace((V)^(-1)*S)));
nu = d*(d+1)/2-(d*k+1-k*(k-1)/2);
p = 1-chi2cdf(log_test, nu);
sprintf('Null Hypothesis: %d - factors model using PPCA is sufficient. \n Log-likelihood ratio %d with degrees of freedom %d \n p-value is %d', k, log_test, nu, p)
end


