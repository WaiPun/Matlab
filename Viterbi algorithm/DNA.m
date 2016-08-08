function c = forward(y)

mat
y = [1,3,1,1,3,2,3,4,3]';
l = length(y);
N = length(A);
a = zeros(length(A),l);


for i = 1:N
a(i,1) = P(y(1),1)*pi(i);
end


for t = 2:l
    for j = 2:N
        a(j,t) = P(y(t),j)*dot(A(:,j),a(:,t-1)) ;
    end
end
    
f=sum(a);
c = f(l)