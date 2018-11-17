clc
clear all
rng default  
mu1 = [0 0];
sigma1 = [1 0; 0 1];
R1 = mvnrnd(mu1,sigma1,100);

mu2 = [5 6];
sigma2 = [1 0; 0 1];
R2 = mvnrnd(mu2,sigma2,100);

figure
plot(R1(:,1),R1(:,2),'+')
hold on
plot(R2(:,1),R2(:,2),'o')

y_data=ones(200,1);
y_data(101:200)=2;

x_data=[R1;R2];
%% initialize
% uniform prior distribution
K=2;
d=2;
n=200;
pi=ones(1,K)/K;
% mean for each class
%complete random
mu=rand(K,d);

%choose 2 random points from data set
%mu=x_data(randi(200,2,1),:)
% covariance for each class
for k =1:K
    sigma(:,:,k)=eye(d,d);
end

for iter=1:500
    %% E-step
    for k=1:K
        p(:,k)=pi(k)*mvnpdf(x_data,mu(k,:),sigma(:,:,k)); 
    end
    r=p./sum(p,2);

    %% M-step
    pi=sum(r)/n;
    for k=1:K
        mu(k,:)=sum(r(:,k).*x_data)./sum(r(:,k));
    end
    for k=1:K
        numerator=0;
        for i=1:n
        %sigma(:,:,k)=(sum(r(:,k).*(x_data*x_data')')/sum(r(:,k)))-mu(k,:)'*mu(k,:);
        %sigma(:,:k)=r(:,k).*(x_data-repmat(mu(k,:),n,1))'*(x_data-repmat(mu(k,:),n,1));
        numerator=r(i,k).*(x_data(i,:)'*x_data(i,:))+numerator;
        end
        sigma(:,:,k)=(numerator./sum(r(:,k)))-mu(k,:)'*mu(k,:);
        sigma(:,:,k)=sigma(:,:,k)+ 0.0001*eye(d);
    end
   
    [~,predicted]=max(r,[],2);
    obj_fun(iter)=sum(log(mvnpdf(x_data,mu(predicted,:),sigma(:,:,predicted)))); 
end

%%
ccr=label_clustring_ccr(predicted,2,y_data);

figure(1)
[s,h] = silhouette(x_data,predicted)
title('silhouette for clustering')

%%
figure(2)
G = gmdistribution(mu,sigma)
F = @(x,y) pdf(G,[x y])
plot(x_data(:,1),x_data(:,2),'.')
hold on
ezcontour(F)
