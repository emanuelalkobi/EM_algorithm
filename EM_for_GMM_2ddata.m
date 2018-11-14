tic 
% precompute
x_data=csvread('OldFaithful.csv');
[n,d]=size(x_data);
x_data(:,1) = x_data(:,1) - min(x_data(:,1));  
x_data(:,1) = 4.*x_data(:,1) / max(x_data(:,1));
x_data(:,2) = x_data(:,2) - min(x_data(:,2));  
x_data(:,2) = 4.*x_data(:,2) / max(x_data(:,2));
x_data(:,1) = x_data(:,1)-2;
x_data(:,2) = x_data(:,2)-2;
%% initialize
% uniform prior distribution
K=2;
pi=ones(1,K)/K;
% mean for each class
mu(1,:)=[0,-1];
mu(2,:)=[2,2];
% covariance for each class
for k =1:K
    sigma(:,:,k)=eye(d,d);
end


for iter=1:200

    %% E-step
    %r=zeros(n,K);
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
        sigma(:,:,k)=(numerator/sum(r(:,k)))-mu(k,:)'*mu(k,:);
        sigma(:,:,k)=sigma(:,:,k);
    end
end

% 
% G = gmdistribution(mu,sigma)
% F = @(x,y) pdf(G,[x y])
% plot(x_data(:,1),x_data(:,2),'.')
% hold on
% ezcontour(F)
% hold on
figure(1)
[~,predict]=max(r,[],2)
[s,h] = silhouette(x_data,predict)
title('silhouette for  clustering')