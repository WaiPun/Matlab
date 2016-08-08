function [misclassified_crossn, misclassified_crossf, class_crossn, class_crossf] = crossvalidate(y, dat)
[n , ~] = size(dat);
y1 = y==1;
y2 = y==2;
N1 = length(y(y==1));
N2 = length(y(y==2));
class_crossn = zeros(n, 1);
class_crossf = zeros(n, 1);

    for i = 1:n
        y_new = dat(i, :);
        label = y;
        label(i) = [];
        leftout_dat = dat;
        leftout_dat(i, :) = [];
        [~,~, class_newn] = normaldisc(label, leftout_dat, y_new);
        [~,~, class_newf] = fisherdisc(label, leftout_dat, y_new);
        class_crossn(i) = class_newn;
        class_crossf(i) = class_newf;
    end

 
misclassified_crossn = abs(y-class_crossn);
misclassified_crossf = abs(y-class_crossf);

cases = 1:n;
cases_n = cases.*misclassified_crossn';
cases_f = cases.*misclassified_crossf';

sprintf('Using Normal rule \n Misclassifications in class 1 & class 2 are: \n Class 1:  %d out of %d \n Class 2:  %d out of %d \n Prediction error: %d ', sum(misclassified_crossn(y==1)),N1, sum(misclassified_crossn(y==2)),N2, mean(misclassified_crossn))

cases_n1 = cases_n.*y1';
cases_n2 = cases_n.*y2';
disp('Class 1:')
disp(cases_n1(cases_n1~=0));
disp('Class 2:')
disp(cases_n2(cases_n2~=0));




sprintf('Using Fisher rule \n Misclassifications in class 1 & class 2 are: \n Class 1:  %d out of %d \n Class 2:  %d out of %d \n Prediction error: %d ',  sum(misclassified_crossf(y==1)),N1, sum(misclassified_crossf(y==2)),N2, mean(misclassified_crossf))
cases_f1 = cases_f.*y1';
cases_f2 = cases_f.*y2';

disp('Class 1:')
disp(cases_f1(cases_f1~=0));
disp('Class 2:')
disp(cases_f2(cases_f2~=0));







end