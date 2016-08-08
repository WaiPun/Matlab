function plot_matrix(X)
[n,d]= size(X);
k = 1;
figure
c = colormap( jet(n)) ;
c = c(randperm(n),:);
for i = 1:d
    for j  = 1:d
        if i==j 
            subplot(d,d,k)
            hist(X(:,i))
            k= k+1;
        else
            subplot(d,d,k)
            scatter(X(:,j),X(:,i), [],c);
            k = k+1;
            
        end


    end



end