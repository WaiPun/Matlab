function [y_pred, misclassified, class_new, eta] = fisherdisc1(y,D,y_new)
% D- data
% y- label must be 1 or 2
% y_new prediction
[n,~] = size(D);
y1 = y==1;
y2 = y==2;

D1 = D(y==1,:);
D2 = D(y==2,:);
sigma1 = cov(D1);
sigma2 = cov(D2);

mean1 = mean(D1,1);
mean2 = mean(D2,1);
mean_b = mean([mean1;mean2],1);

B = cov([mean1; mean2]);
W = sigma1+sigma2;

[eta delta]  = eig(W^(-1)*B);
[~, k] = max(diag(delta));
eta = eta(:,k);
% misclassified
y_pred = zeros(length(y),1);
for i = 1:length(y)
    if abs((D(i,:)-mean1)*eta) < abs((D(i,:)-mean2)*eta) 
    y_pred(i) = 1;
    else
        y_pred(i) = 2;
    end
end
misclassified = abs(y-y_pred);
    % new prediction
if y_new(1) ~= 'No_input'
            if abs((y_new-mean1)*eta) < abs((y_new-mean2)*eta) 
                    class_new = 1;
            else
                    class_new = 2;
            end
            else
        class_new = 'No_input';
end   


%%%%%%%%%%%%
% Display outcomes
%%%%%%%%%%%%
casesf = 1:n;
casesf = casesf.*misclassified';
sprintf('Using Fisher''s rule \n Misclassifications in class 1 & class 2 are: \n Class 1:  %d out of %d \n Class 2:  %d out of %d \n Prediction error: %d ', sum(misclassified(y1)),sum(y1), sum(misclassified(y2)),sum(y2), mean(misclassified))

cases1 = casesf.*y1';
cases2 = casesf.*y2';
disp('Class 1:')
disp(cases1(cases1~=0));
disp('Class 2:')
disp(cases2(cases2~=0));















end