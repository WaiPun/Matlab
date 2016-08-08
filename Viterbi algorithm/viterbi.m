function [c,s] = viterbi(y,A,P,pi)
% This is a viterbi function to choose the most likely states for the
% observed sequence y.
% A, P, pi are the transition matrix, P(y|x) matrix and initial
% distribution.
% outputs are c, marginal probabilty, and, s the most likely states
% Wai Pun 1205298 29 Oct 2013



l = length(y);
s = zeros(1,l);

[c,a] = forward(y,A,P,pi);

for i = 1:l
    [~,x] = max(a(:,i));
    s(i) = x;
end
