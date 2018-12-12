%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs    : X             - The n data points in R^d size  (size n*d)   %
%             pi            - Vector w/ prior prob. for each class k (k*1)%
%             Mu            - Bernouli Prob. distr. Param. (p,k mix.)(k*d)%
%                             (n*d)                                       %
% Outputs   : r             - rik = responsibility of clust. k for data xi%
%                             (n*k)                                       %
%                                                                         %
% Variable Naming Convention: (var)_(property/parameters);                %
%                                                                         %
%                                                                         %  
function [r] = Estep(X,Pi,Mu)
    X = sparse(X);
    logP = log(Mu)*X' + log(1-Mu)*(1-X');   % log of Product of bernouli
    logNum = log(Pi') + logP;               % log(Pi*P) = log(Pi) + log(P)
    logDenom = LSE(logNum);                 % log(sum(Pi*P)) = log(sum(exp(log(Pi*P)))) = log(sum(exp(logNum)))
    lnR = logNum - logDenom;                % log(r) = log(Pi*P/sum(Pi*P)) = log(Pi*P) - log(sum(Pi*P))
    r = exp(lnR)';
end