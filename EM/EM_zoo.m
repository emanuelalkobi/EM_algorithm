%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EM aglorith for zoo data set  with different types of         %
%initialization                                                           %                                                              %
%data set properties:                                                     %
% x_data- n*d matrix .n-number of samples , d-dimension of samples        %
% y_data- n*1 vector.It is the ground truth labels for x_data.            %
 

%%
%%set parameters for sampling
clc
clear all
rng default 
[x_data,y_data,animals_name] = process_data_zoo();

[K,~]=size(unique(y_data));
%%
[~,y_predicted_rnd]=EM(x_data,K,'random',50,10^-12,'MAP');
[~,y_predicted_rnd_data]=EM(x_data,K,'data_random',50,10^-12,'MAP');
[~,y_predicted_k_means]=EM(x_data,K,'k_means',500,10^-12,'MAP');
y_k_means=kmeans(x_data,K);




%%
%results
ccr_random=label_clustring_ccr(y_predicted_rnd,K,y_data);
ccr_data_random=label_clustring_ccr(y_predicted_rnd_data,K,y_data);
ccr_k_means=label_clustring_ccr(y_predicted_k_means,K,y_data);
ccr_y_k_means=label_clustring_ccr(y_k_means,K,y_data);
%figure(1)
%[s,h] = silhouette(x_data,predicted)
%title('silhouette for clustering')

