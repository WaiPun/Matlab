function Y = sphered(X)
% sphering the data X; 
X = demean(X);
[Q,D] = eig(cov(X));
Y = Q*D^(-1/2)*Q'*X';
Y = Y';
end