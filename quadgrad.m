function [x fx grad normf] = quadgrad(A,b,c,x0)
%%% Setting up the function we want to minimise.
%%% Initial Conditions

eps = 0.0005;
x = zeros(length(b),101);
fx = zeros(1,101);
grad = x;
normf = zeros(1,101);
x(:,1) = x0;

%%% iterations
for i = 1:100
    if (norm(A*x(:,i)+b)).^2<eps
        n = i; break; end
    u = -A*x(:,i)-b;
    r = (u'*u)/(u'*A*u);
    xn = x(:,i)+r*u;
    x(:,i+1) = xn;
    fx(i+1) = xn'*A*xn+b'*xn+c;
    grad(:,i+1) = -r*u;
    normf(i+1) = r*norm(u)^2;
    n = i;
end
x = x (:,1:n);
fx = fx(1:n);
grad = grad(:,1:n);
normf = normf(1:n);



