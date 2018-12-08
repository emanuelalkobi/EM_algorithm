%% 3 mixture of gaussian kmeans and EM comparison
clc
clear
mu1 = [0.22 0.45];
mu2=[0.5 0.5];
mu3=[0.77 0.55];
Sigma2 = [0.018  0.01 ;  0.01 0.011];
Sigma1 = [0.011 -0.01 ; -0.01 0.018];
Sigma3 = Sigma1;
mixmat = [0.5 0.3 0.2]';
r1=mvnrnd(mu1,Sigma1,100);
r2=mvnrnd(mu2,Sigma2,100);
r3=mvnrnd(mu3,Sigma3,100);
figure(1)
subplot(3,2,1)
plot(r1(:,1),r1(:,2),'.r')
hold on
plot(r2(:,1),r2(:,2),'.g')
plot(r3(:,1),r3(:,2),'.b')
title('original data')
x_data=[r1;r2;r3];
y_data=[ones(100,1);2*ones(100,1);3*ones(100,1)];
[y_k_means,C]=kmeans(x_data,3);
subplot(3,2,2)
plot(x_data(y_k_means==1,1),x_data(y_k_means==1,2),'b.')
hold on
plot(C(1,1),C(1,2),'kx','markersize',5)
plot(x_data(y_k_means==2,1),x_data(y_k_means==2,2),'r.')
plot(C(2,1),C(2,2),'kx','markersize',5)
plot(x_data(y_k_means==3,1),x_data(y_k_means==3,2),'g.')
plot(C(3,1),C(3,2),'kx','markersize',5)
title('kmeans')
[~,y_predicted_rnd]=EM(x_data,3,'random',500,10^-5,'ML');
[~,y_predicted_rnd_data]=EM(x_data,3,'data_random',500,10^-5,'ML');
[~,y_predicted_k_means]=EM(x_data,3,'k_means',500,10^-5,'ML');

subplot(3,2,3)
plot(x_data(y_predicted_rnd==1,1),x_data(y_predicted_rnd==1,2),'g.')
hold on
plot(x_data(y_predicted_rnd==2,1),x_data(y_predicted_rnd==2,2),'r.')
plot(x_data(y_predicted_rnd==3,1),x_data(y_predicted_rnd==3,2),'b.')
title('initialize with random value')
subplot(3,2,4)
plot(x_data(y_predicted_rnd_data==1,1),x_data(y_predicted_rnd_data==1,2),'g.')
hold on
plot(x_data(y_predicted_rnd_data==2,1),x_data(y_predicted_rnd_data==2,2),'b.')
plot(x_data(y_predicted_rnd_data==3,1),x_data(y_predicted_rnd_data==3,2),'r.')
title('initialize with random data')
subplot(3,2,5)
plot(x_data(y_predicted_k_means==1,1),x_data(y_predicted_k_means==1,2),'r.')
hold on
plot(x_data(y_predicted_k_means==2,1),x_data(y_predicted_k_means==2,2),'b.')
plot(x_data(y_predicted_k_means==3,1),x_data(y_predicted_k_means==3,2),'g.')
title('initialize with kmeans')

ccr_random=label_clustring_ccr(y_predicted_rnd,3,y_data);
ccr_data_random=label_clustring_ccr(y_predicted_rnd_data,3,y_data);
ccr_k_means=label_clustring_ccr(y_predicted_k_means,3,y_data);

