function [within between] = within_var(dat,class)
% kmeans within-cluster criteria
within = 0;
[~, d] = size(dat);
a = unique(class)';
mean_cluster = zeros(length(a), d);
for i = a
    cluster_dat = dat(class==i,:);
    mean_cluster(i,:) = mean(cluster_dat, 1);
    [n_c, ~] = size(cluster_dat);
    w_i = 0;
    for j = 1:n_c
        w_i = w_i+norm(cluster_dat(j,:)-mean_cluster(i,:))^2;
    end
    within = within+w_i;
end

between = 0;

for i = a
    mean_mean  = mean(dat,1);
    between = between + norm(mean_cluster(i,:)-mean_mean)^2;
end
end





