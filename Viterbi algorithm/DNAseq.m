l = 6;
seq = [1,2,1,1,2,3,1,3,2];
% A is the transition Matrix; pi is the inital distribution, P is the
% Matrix of probability of getting observation condition on S_x
P = [ 4/5 0 4/5 1 0 0 1/5; 0 4/5 1/5 0 0 3/5 1/5; 0 1/5 0 0 1/5 2/5 2/5; 1/5 0 0 0 4/5 0 1/5];
A = [0 0 0 0 0 0 1 ; 0 0 1/2 0 0 1/2 0 ; 0 0 0 0 0 0 1 ];
A = [ zeros(8,1),[eye(5),zeros(5,2);A]];
init = [1, zeros(1,7)];

S = [1,2,3,4]; % to respresent A,C,G,T

a = zeros(length(A),10);
for i = S
a(i,1) = P(seq(1),1)*init(i);
end


for t = 2:l-1
    for j = 2:7
        a(j,t) = P(seq(t),j)*dot(A(:,j),a(:,t-1)) ;
    end
end
    
a;
