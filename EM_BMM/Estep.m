%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author    : Aman Gupta                                                  %
% Inputs    : X             - The n data points in R^d size  (size n*d)   %
%             K             - Number of different classes/Clusters.       %
%             pi            - Vector w/ prior prob. for each class k (k*1)%
%             Mu            - Bernouli Prob. distr. Param. (p,k mix.)(k*1)%
%                             (n*d)                                       %
% Outputs   : r             - rik = responsibility of clust. k for data xi%
%                             (n*k)                                       %
%                                                                         %
% Variable Naming Convention: (var)_(property/parameters);                %
%                                                                         %
%                                                                         %  
function [r] = Estep(X,K,Pi,Mu)
    X = sparse(X);
    n = 1;                    % Binomial with n=1,
    [N,D] = size(X);
    p = zeros(N,K);
    for k = 1:K
        Bern = zeros(N,D);
        for d = 1:D
            Bern(:,d) = binopdf(X(:,d),n,Mu(k,d));
        end
        p(:,k) = Pi(k)*(prod(Bern,2));
    end
    r = p./sum(p,2);
end