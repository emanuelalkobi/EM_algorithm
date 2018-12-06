%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EM aglorith for Oldfaithful data set  with different types of         %
%initialization                                                           %                                                              %
%data set properties:                                                     %
% x_data- n*d matrix .n-number of samples , d-dimension of samples        %
% y_data- n*1 vector.It is the ground truth labels for x_data.            %
% 
 
clc
clear
rng default 
[x_data]=process_data_oldfaithful();

K=2;
%Use result of k means as ground truth.
[y_data,C]=kmeans(x_data,K);
%% 
[out1,y_predicted_rnd]=EM(x_data,K,'random',50,10^-12,'ML',[1,5,10,15,20,25,30,36]);
saveas(out1,'initialize with random value.jpg')
clf('reset')
[out2,y_predicted_rnd_data]=EM(x_data,K,'data_random',50,10^-12,'ML',[1,5,10,18]);
saveas(out2,'initialize with random data.jpg')
clf('reset')
[out3,y_predicted_k_means]=EM(x_data,K,'k_means',500,10^-12,'ML',[1,5,10,14]);
saveas(out3,'initialize with k means.jpg')
clf('reset')
%%
%results
ccr_random=label_clustring_ccr(y_predicted_rnd,K,y_data);
ccr_data_random=label_clustring_ccr(y_predicted_rnd_data,K,y_data);
ccr_k_means=label_clustring_ccr(y_predicted_k_means,K,y_data);

figure(1)
subplot(2,2,1)
plot(x_data(y_data==1,1),x_data(y_data==1,2),'r.'); 
hold on
plot(x_data(y_data==2,1),x_data(y_data==2,2),'b.');
plot(C(:,1),C(:,2),'xk','MarkerSize',8,'linewidth',5)
title('Clustering by k means algorithm')
subplot(2,2,2)
plot(x_data(y_predicted_rnd==1,1),x_data(y_predicted_rnd==1,2),'b.'); 
hold on
plot(x_data(y_predicted_rnd==2,1),x_data(y_predicted_rnd==2,2),'r.'); 
title('Clustering by EM algorithm initilized by random value')
subplot(2,2,3)
plot(x_data(y_predicted_rnd_data==1,1),x_data(y_predicted_rnd_data==1,2),'r.'); 
hold on
plot(x_data(y_predicted_rnd_data==2,1),x_data(y_predicted_rnd_data==2,2),'b.'); 
title('Clustering by EM algorithm initilized by random data')
subplot(2,2,4)
plot(x_data(y_predicted_k_means==1,1),x_data(y_predicted_k_means==1,2),'b.'); 
hold on
plot(x_data(y_predicted_k_means==2,1),x_data(y_predicted_k_means==2,2),'r.');
title('Clustering by EM algorithm initilized by k means')



