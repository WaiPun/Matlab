function [Xcent] = demean(X)
% Row  = n; col = d
% column wise demeaning
[n, d] = size(X);
m = mean(X);
m = repmat(m, n,1);
Xcent = X-m;





end


