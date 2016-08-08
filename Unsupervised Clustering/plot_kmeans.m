function [] = plot_kmeans(dat, k)


[~, sortorder] = sort(diag(cov(dat)), 'descend');
var_i = sortorder(1:3);
%var_i = [ 1 2 3];


figure ;
grid on;

class = kmeans(dat, k);
N = length(unique(class));
c = colormap(jet(N)) ;
c = c(randperm(N),:);
for i = unique(class)'
hold on
P = [dat(class==i,var_i(1)),dat(class==i,var_i(2)),dat(class==i,var_i(3))];
k = convhull(P(:,1),P(:,2),P(:,3));
plot3(P(:,1),P(:,2),P(:,3),'*','Color',c(i,:))
trisurf(k,P(:,1),P(:,2),P(:,3),'Facecolor',c(i,:),'FaceAlpha',0.1)
end
hold off
end



