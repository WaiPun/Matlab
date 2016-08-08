function [c,a] = forward(y,A,P,pi)
% this is the forward algorithm to determine the marginal probabilty of the
% observed sequence y.
% A, P, pi are the transition matrix, P(Y|X) matrix and initial
% distribution.
% outputs are c the marginal probability and a_l(i) matrix
% Wai Pun 1205298 29 Oct 2013




l = length(y);
N = length(A);
a = zeros(length(A),l);


for i = 1:N
a(i,1) = P(y(1),i)*pi(i);
end


for t = 2:l
    for j = 1:N
        a(j,t) = P(y(t),j)*dot(A(:,j),a(:,t-1)) ;
    end
end
    
f=sum(a);
c = f(l);