%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : m_step                                              %
% Inputs    : x_data     - The n data points in R^d size (total sizen*d)  %
%           : K - Number of different classes.                            %
%             r      - output of the EM algorithm Expectation part.       %
%                      r will be of size of n*K and it will hold the      %
%                      probability for each class.                        %
% Outputs   :
%             pi      - Vector of length K with prior probabilty for each %
%             class                                                       %
%             mu      - Matrix of K mean value for each class.            %
%             sigma   - K covariance matrixes                             %
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  

function [pi,mu,sigma] = m_step(x_data,K,r)
    [n,d]=size(x_data);
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

