function [A,B,R,U,V] = myCCA(dat1, dat2)

[n, d1] = size(dat1);
[~, d2] = size(dat2);

[A,B,R,U,V] = canoncorr(sphered(dat1), sphered(dat2));
disp('Singular values')
disp(R);
disp('X1 transform')
disp(A);
disp('X2 transform')
disp(B);

for i = 1:min(d1,d2)
subplot(min(d1,d2),1,i)
plot(U(:,i), V(:,i), 'o')
end
%%%%%%%%%%%%%%%%%%%%%%
% Hypothesis testing
%%%%%%%%%%%%%%%%%%%%%%
r = min(d1,d2);

log_test = -(n-1/2*(d1+d2+3))*log(1-R(r)^2);
k_test = r-1;
df = (d1-k_test)*(d2-k_test);

p = 1-chi2cdf(log_test, df);

sprintf('Hypothesis testing: the last singular value is equal to 0. \n The observed test statistics is %d with degrees of freedom %d \n Giving the p-value %d', log_test, df, p)
%%%%%%%%%%%%%%%%%%%%%%
% Histogram of each scores
%%%%%%%%%%%%%%%%%%%%%%
figure
s = 1;
for i = 1:r
        subplot(r,2,s)
        hist(U(:,i),25)
        title(sprintf('Histogram of U%d', i))
        s = s+1;
        subplot(r,2,s)
        hist(V(:,i),25)
        title(sprintf('Histogram of V%d', i))
        s = s+1;
end


figure
s = 1;
for i = 1:r
        subplot(r,2,s)
        ksdensity(U(:,i));
        title(sprintf('Kernel kensity of U%d', i))
        s = s+1;
        subplot(r,2,s)
        ksdensity(V(:,i));
        title(sprintf('Kernel kensity of V%d', i))
        s = s+1;
end

end