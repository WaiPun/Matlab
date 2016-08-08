function [within ] = myCA(dat)
% Run Hierarchical Agglormative clustering
% k-means considering k = 1,...,10.
% optimal of choosing using 4 criteria
[n,d] = size(dat);
y = pdist(dat);
wmat = linkage(y, 'single');
subplot(4,1,1)
dendrogram(wmat);
title('Single linkage- Euclidean Distance')
subplot(4,1,2)
dendrogram(linkage(y, 'complete'));
title('Complete linkage- Euclidean Distance')
subplot(4,1,3)
dendrogram(linkage(y, 'average'));
title('Average linkage- Euclidean Distance')
subplot(4,1,4)
dendrogram(linkage(y, 'centroid'));
title('Centroid linkage- Euclidean Distance')

figure
y = pdist(dat,'cosine');
subplot(4,1,1)
dendrogram(linkage(y, 'single'));
title('Single linkage- Cosine Distance')
subplot(4,1,2)
dendrogram(linkage(y, 'complete'));
title('Conplete linkage- Cosine Distance')
subplot(4,1,3)
dendrogram(linkage(y, 'average'));
title('Average linkage- Cosine Distance')
subplot(4,1,4)
dendrogram(linkage(y, 'centroid'));
title('Centroid linkage- Cosine Distance')


WB = zeros(10,2);
for k = 1:10
    class = kmeans(dat,k);
    [w, b] = within_var(dat,class);
    WB(k,1) = w;
    WB(k,2) = b;
end

figure
plot(WB(:,1),'o-')
title('Within-cluster variability')

% CH
k = 1:9;
CH1 =  (WB(2:9,2)./((2:9)-1)');
CH2 =  (WB(2:9,1)./(n-(2:9))');
CH = [0; CH1./CH2];
H = (WB(1:9,1)./WB(2:10,1)-1).*(n-k-1)';

k1 = 2:10;
Diff = [0; ((k1-1).^(2/d))'.*WB(1:9,1)-(k.^(2/d))'.*WB(2:10,1)];
KL = Diff(1:9)./Diff(2:10);

WV = WB(1:9,1)./WB(2:10,1);
figure
subplot(4,1,1)
plot(CH,'o-')
title('Calinski and Harabasz (1974): argmax CH(k)')
subplot(4,1,2)
plot(H,'o-')
hold on 
hline = refline([0 10]);
hline.Color = 'r';
hold off
title('Hartigan (1975): min{k:H(k)<10}')
subplot(4,1,3)
plot(KL,'o-')
title('Krzanowski and Lai (1988): argmax KL(k)')
subplot(4,1,4)
plot(WV,'o-')
hold on
hline = refline([0 1.2]);
hline.Color = 'r';
title('Withn-cluster variability: max{k: WV(k)> 1.2}')
hold off
within = WB(:,1);
    
end



% k-means considering k = 1,,,10


