clc
clear all
miss_ratio=[0:0.01:0.50]


for i=1:length(miss_ratio)
    i
    rng default 
    rng default 
    samples_num=200;
    mu1 = [3 1];
    sigma1 = [1 0; 0 1];
    R1 = mvnrnd(mu1,sigma1,100);
    mu2 = [0 3];
    sigma2 = [2 1; 1 2];
    R2 = mvnrnd(mu2,sigma2,100);
    K=2;


    y_data=ones(samples_num,1);
    y_data(101:samples_num)=2;
    x_data=[R1;R2];
    [n,d]=size(x_data);
    x_miss = x_data;
    miss_ratio_curr = miss_ratio(i);
    x_miss(rand(n,d)<miss_ratio_curr) = NaN;
    y_miss=y_data;
    y_miss(sum(isnan(x_miss),2)==2)=[];
    % remove rows that have only NaN values
    x_miss(sum(isnan(x_miss),2)==2,:) = [];
    y_predicted_rnd=EM(x_miss,K,'random',500,10^-5);
    y_predicted_rnd_data=EM(x_miss,K,'data_random',500,10^-5);
    y_predicted_k_means=EM(x_miss,K,'k_means',500,10^-5);
    %ccr_random(i)=label_clustring_ccr(y_predicted_rnd,K,y_miss);
    %ccr_data_random(i)=label_clustring_ccr(y_predicted_rnd_data,K,y_miss);
    ccr_k_means(i)=label_clustring_ccr(y_predicted_k_means,K,y_miss);

end
%%

    
    figure(1)
    
    plot(R1(:,1),R1(:,2),'+')
    hold on
    plot(R2(:,1),R2(:,2),'o')
    xlabel('x')
    ylabel('y')
    title('2-d gaussian data set')
    legend('gauussian data 1','gauussian data 1')
    
    figure(2)
    y_tmp=ccr_k_means(1);
    x_tmp=0    
    plot(x_tmp,y_tmp,'*')
    hold on
    plot(miss_ratio,ccr_k_means)
    xlabel('missing percentage ratio')
    ylabel('CCR')
    title('CCR as function of missing data percentage ')

    
