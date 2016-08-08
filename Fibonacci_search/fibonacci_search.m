function [x,y,fin_interval, step] = fibonacci_search(f,a0,b0,eps)

N = ceil(log((sqrt(5)*(b0-a0))/eps)/log((1+sqrt(5)/2))-2);
gam = fibonacciN(N)/fibonacciN(N+1);

a = zeros(N,1);
b = zeros(N,1);
p = zeros(N,1);
q = zeros(N,1);
fp = zeros(N,1);
fq = zeros(N,1);

a(1) = a0;
b(1) = b0;
p(1) = b(1)-gam*(b(1)-a(1));
q(1) = a(1)+gam*(b(1)-a(1));
fp(1) = f(p(1));
fq(1) = f(q(1));

for i = 1:N-1
    if fp(i)<fq(i)
        a(i+1) = a(i);
        b(i+1) = q(i);
        q(i+1) = p(i);
        fq(i+1) = fp(i); 
        p(i+1) = a(i+1)+b(i+1)-q(i+1);
        fp(i+1) = f(p(i+1));
    else
        a(i+1) = p(i);
        b(i+1) = b(i);
        p(i+1) = q(i); 
        fp(i+1) = fq(i);
        q(i+1) = a(i+1)+b(i+1)-p(i+1); 
        fq(i+1) = f(q(i+1));
    end
end
s = [ a(N) p(N) q(N) b(N)];
[y,x] = min(f(s));
x = s(x);
ap = (a(N)+ p(N))/2;
step = [a,p,q,b,fp,fq];
if f(ap)<f(p)
    fin_interval = [a(N),p(N)];
else
    fin_interval = [p(N),b(N)];
end
    
