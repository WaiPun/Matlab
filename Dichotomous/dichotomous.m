function [x,y] = dichotomous(f,a,b,eps)
N = ceil(log((b-a)/eps)/log(2));
c = (a+b)/2;
d = (a+c)/2;
e = (c+b)/2;

for i = 1:N
if f(d) == min(f([c,d,e]))
    b = c;
    c = d;
    d = (a+c)/2;
    e = (c+b)/2;
elseif f(c) == min(f([c,d,e]))
    a = d;
    b = e;
    d = (a+c)/2;
    e = (c+b)/2;
else f(e) == min(f([c,d,e]))
    a = c;
    c = e; 
    d = (a+c)/2;
    e = (c+b)/2;
end
end
[y,x] = min(f([d,c,e]));
s = [d,c,e]; 
x = s(x);

        
        
        
        
        