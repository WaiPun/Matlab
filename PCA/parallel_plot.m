function parallel_plot(X,i)
% plot parallel coordinate plot for X
% i = 1 red to blue colour according to the first variable
% i = 2 random distinct colours
% i = other random colours from the colour map.
% W PUN 2014.
%Y = sortrows( X,1 ) ; 
Y = X;
N = size( X,1 ) ;
if i == 1
c = colormap(jet(size( Y,1 ))) ;
elseif i == 2
    c = varycolor(N);
else
c = colormap( jet( size( Y,1 ))) ;
c = c(randperm(N),:);
end
for i=1:N
    hold on; parallelcoords( Y( i,: ), 'Color', c( i,: ) ) ; 
end
hold off
end