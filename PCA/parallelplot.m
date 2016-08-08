function [~] = parallel_plot(X)
m = min( X ) ; M = max( X) ;

Z = ( X - repmat( m, size( X,1 ),1 ) ) ./ ( repmat( M, size( X,1 ),1 ) - repmat( m, size( X,1 ),1 ) ) ;

figure

Y = sortrows( Z,1 ) ; N = size( Z,1 ) ;

c = colormap( jet( size( Y,1 ))) ;

for i=1:N

    hold on; parallelcoords( Y( i,: ), 'Color', c( i,: ) ) ; 

end
end