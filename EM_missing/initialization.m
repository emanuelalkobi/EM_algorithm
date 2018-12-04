%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : initialization                                              %
% Inputs    : x_data     - The n data points in R^d size (total sizen*d)  %
%           : K - Number of different classes.                            %
%           : method   - The way to initialize the parameters:            %
%           'random'-Choose completly random values for the mean of       %
%            clasess.                                                     %
%           'data_random'-Choose K random points from X_data to be the    %
%           initial mean of clasess.                                      %
%           'k_means'-Use k means algorith for initial all the output     %
%           parameters.                                                   %
% Outputs   :
%             pi      - Vector of length K with prior probabilty for each %
%             class                                                       %
%             mu      - Matrix of K mean value for each class.            %
%             sigma   - K covariance matrixes                             %
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  

function [pi,mu,sigma] = initialization(x_data,K,method)
    rng(9);
    [n,d]=size(x_data);
    if strcmp(method,'random')
            rng(9);

        pi=ones(1,K)/K;
        mu=rand(K,d);
        for i =1:K
            sigma(:,:,i)=eye(d,d);
        end
    end
    
    if strcmp(method,'data_random')
        %need to pick observed points from the data set(no Nan values)
        mu=x_data(randi(n,K,1),:);
        if sum(sum(isnan(mu)))>0
            [i,j]=find(isnan(mu));
            mu(i,j)=rand(length(i),length(j));  
        
        end
        pi=ones(1,K)/K;
        for i =1:K
            sigma(:,:,i)=eye(d,d);
        end
    end  
    
    if strcmp(method,'k_means')
        %take only observed data to initialize
        x_o=x_data(sum(isnan(x_data),2)==0,:);
        [L,C] = kmeans(x_o,K);	
        mu = C;
        pi = hist(L,K)./length(L);
        for i = 1:K
            sigma(:,:,i) = cov(x_o(L==i,:))+ 0.0001*eye(d);
        end
    end

end

