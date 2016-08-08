function [COEFF, SCORE, LATENT] = myPCA(dat)
figure
parallel_plot(dat, 1)
title('Parallel plot of the dataset')

[~, d] = size(dat);
[COEFF, SCORE, LATENT] = pca(dat);

figure
subplot(2,1,1)
plot(LATENT/sum(LATENT),'o-');
title('Percentage of total variance explained')
subplot(2,1,2)
plot(cumsum(LATENT/sum(LATENT)),'o-');
title('Cumulative percentage of total variance explained')

kmax = min(5,d);
figure
plotmatrix(SCORE(:,1:kmax))

ddat = demean(dat);

% Set k = 4; 
k = 4;
figure
for i = 1:k
    subplot(k,1,i);
    etak = COEFF(:,i);
    P = etak*etak'*ddat';
    parallel_plot(P',1);
    title(sprintf('Parallel coordinate plot of PC %d projection data' ,i))
end


end