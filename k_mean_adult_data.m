
%%
clc;
clear all;
[x_data,y_data]=process_data_adult()
cluster_num=2;
%k means algorith to 2 clusters
[clusters,C] = kmeans(x_data,cluster_num);

original_clusters=clusters
%calculating ccr based on truth labels
groups=[1:1:cluster_num];
p = perms(groups)
size_p=size(p)

ccr=label_clustring_ccr(clusters,cluster_num,y_data);



%calculating silhouette values 
[s,h] = silhouette(x_data,clusters)



%%
A       = clusters;
oldCode = [ 1  2];
newCode = [10 20];

[a,b] = ismember(A,oldCode);

A(a) = newCode(b(a));












