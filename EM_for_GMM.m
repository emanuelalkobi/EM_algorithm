tic 
rng(1)
% precompute
[x_data,y_data,animals_name] = process_data_zoo();
[n,d]=size(x_data);
%% initialize
% uniform prior distribution
[K,~]=size(unique(y_data));
pi=ones(1,K)/K;
% mean for each class
mu=rand(K,d);
% covariance for each class
for k =1:K
    sigma(:,:,k)=eye(d,d);
end

for iter=1:30
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

figure(1)
[~,predict]=max(r,[],2)
[s,h] = silhouette(x_data,predict)
title('silhouette for clustering')
figure(2)
plot(obj_fun);
xlabel('iteration')
ylabel('value of log likelihood')
title('log likelihood function')