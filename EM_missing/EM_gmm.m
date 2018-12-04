%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EM aglorith for a Gaussian mixture model with different types of         %
%initialization                                                           %                                                              %
%data set properties:                                                     %
% x_data- n*d matrix .n-number of samples , d-dimension of samples        %
% y_data- n*1 vector.It is the ground truth labels for x_data.            %
% miss ratio should be greater than 0

%%
%%set parameters for sampling
%%
%%set parameters for sampling
clc
clear all
rng default 
rng default 
samples_num=200;
mu1 = [3 1];
sigma1 = [1 0; 0 1];
R1 = mvnrnd(mu1,sigma1,100);
mu2 = [0 3];
sigma2 = [2 1; 1 2];
R2 = mvnrnd(mu2,sigma2,100);

%figure
%plot(R1(:,1),R1(:,2),'+')
%hold on
%plot(R2(:,1),R2(:,2),'o')

y_data=ones(samples_num,1);
y_data(101:samples_num)=2;
x_data=[R1;R2];
[n,d]=size(x_data);

K=2;
%%
%%remove some data
x_miss = x_data;
miss_ratio = 0;
x_miss(rand(n,d)<miss_ratio) = NaN;
y_miss=y_data;
y_miss(sum(isnan(x_miss),2)==2)=[];
% remove rows that have only NaN values
x_miss(sum(isnan(x_miss),2)==2,:) = [];
x_data=x_miss;
%%
y_predicted_rnd=EM(x_data,K,'random',500,10^-5);
y_predicted_rnd_data=EM(x_data,K,'data_random',500,10^-5);
y_predicted_k_means=EM(x_data,K,'k_means',500,10^-5);





%%
%results
ccr_random=label_clustring_ccr(y_predicted_rnd,K,y_miss);
ccr_data_random=label_clustring_ccr(y_predicted_rnd_data,K,y_miss);
ccr_k_means=label_clustring_ccr(y_predicted_k_means,K,y_miss);

%figure(1)
%[s,h] = silhouette(x_data,predicted)
%title('silhouette for clustering')

