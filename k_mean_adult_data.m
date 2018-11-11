
%%
clc;
clear all;
[x_data,y_data]=process_data_adult()
%k means algorith to 2 clusters
[clusters,C] = kmeans(x_data,2);


%calculating ccr based on truth labels 
Con_out=confusionmat(idx,clusters);
CCR_out=trace(Con_out)/sum(sum(Con_out));

%calculating silhouette values 
[s,h] = silhouette(x_data,clusters)






