 
clc;
clear all;
rng(1)
[x_data,y_data,animals_name] = process_data_zoo();
labels=size(unique(y_data));

cluster_num=labels(1);
figure(1)

[clusters,C] = kmeans(x_data,cluster_num);
[s,h] = silhouette(x_data,clusters)
title('silhouette for k means clustering')

%ccr 
ccr=label_clustring_ccr(clusters,cluster_num,y_data);


%%silhouette for birds only
y_birds=((find(y_data==2)))
x_birds=x_data(y_birds,:)
%calculating  birds silhouette values 
figure(2)
[s,h] = silhouette(x_birds,clusters(y_birds))
title('silhouette for k means clustering bird label only')


    