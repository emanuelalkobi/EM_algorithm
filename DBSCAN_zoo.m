%% Load Data
[x_data,y_data] = process_data_zoo();
[~,n] = size(x_data');
dist = @(x,y) (sqrt(sum((x-y).^2)));
%% My definition of input parameters 
eps = 0.8*(mean(mean(pdist(x_data))));
minPts = 0.8*(n/length(unique(y_data)));

% if y_data is not known
% minPts = n/numOfClusterWeWant

%% Cluster using DBSCAN
tic
[label] = DBSCAN(sparse(x_data'),dist,eps,minPts);
toc
tic
[label2, cent] = dbscan2(sparse(x_data),eps,minPts);
toc
%% Check performance
figure(1)
tic
[s,h] = silhouette(x_data,label);
toc

figure(2)
tic
[s2,h2] = silhouette(x_data,label2);
toc

%%