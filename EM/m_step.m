%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : m_step                                              %
% Inputs    : x_data     - The n data points in R^d size (total sizen*d)  %
%           : K - Number of different classes.                            %
%             r      - output of the EM algorithm Expectation part.       %
%                      r will be of size of n*K and it will hold the      %
%                      probability for each class. 
%             estimate   -MLEstimate or MAP estimate of parameters
% Outputs   :
%             pi      - Vector of length K with prior probabilty for each %
%             class                                                       %
%             mu      - Matrix of K mean value for each class.            %
%             sigma   - K covariance matrixes                             %
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  

function [pi,mu,sigma] = m_step(x_data,K,r,estimate)
    [n,d]=size(x_data);
    if strcmp(estimate,'ML')
        pi=sum(r)/n;
        for k=1:K
            mu(k,:)=sum(r(:,k).*x_data)./sum(r(:,k));
        end
        for k=1:K
            numerator=0;
            for i=1:n
            numerator=r(i,k).*(x_data(i,:)'*x_data(i,:))+numerator;
            end
            sigma(:,:,k)=(numerator./sum(r(:,k)))-mu(k,:)'*mu(k,:);
            sigma(:,:,k)=sigma(:,:,k)+ 0.0001*eye(d);
        end
    end
    
    if strcmp(estimate,'MAP')
        alpha=ones(1,K);
        pi=(sum(r)+alpha-1)/(n+sum(alpha)-K); % Use Dirichlet prior on the mixture weights parameter.
        % Use conjugate prior (NIW) on mu and sigma 
        for k=1:K
            mu(k,:)=sum(r(:,k).*x_data)./sum(r(:,k));
        end
        
        s=sum((x_data-mean(x_data)).*(x_data-mean(x_data)))/n;
        S0=diag(s)/(K^(1/d));
        v0=d+2;
        for k=1:K
            numerator=0;
            for i=1:n
            numerator=r(i,k).*(x_data(i,:)'*x_data(i,:))+numerator;
            end
            sigma(:,:,k)=(numerator./sum(r(:,k)))-mu(k,:)'*mu(k,:);
            sigma(:,:,k)=(sigma(:,:,k)+S0)/(v0+d+2+sum(r(:,k))) + 0.0001*eye(d);
        end
        
    end
end

