function [x,v] = vit(y,A,P,pi)
% This is a viterbi function to choose the most likely states for the
% observed sequence y.
% A, P, pi are the transition matrix, P(y|x) matrix and initial
% distribution.
% Most likely states 
% Wai Pun 1205298 29 Oct 2013

N = length(A);
L = length(y);

for i = 1:N
    v(i,1) = pi(i)*P(y(1),i);
end


for j = 1:N
    for l = 2:L
        v(j,l) = max(v(:,l-1).*A(:,j)*P(y(l),j));
    end
end

x = zeros(1,L);
[~,x(L)] = max(v(:,l));
for l = (L-1):-1:1
    [~,x(l)]=max(v(:,l).*A(:,x(l+1)));
end
x;