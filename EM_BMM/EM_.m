%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EC 503: Learning from Data                                            %%
%% Boston University                                                     %%
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author    : Aman Gupta                                                  %
% Inputs    : X        - The n data points in R^d size  (size n*d)        %
%             K        - Number of different classes/Clusters.            %
%             iters    - Number of iterations to run the EM algorithm     %
%             eps      - Threshold for convergence                        %
% Outputs   : Y_pred   - Predicted Cluster Ids (n*1)                      %
%                                                                         %
% Variable Naming Convention: (var)_(property/parameters);                %
%                                                                         %
%                                                                         %
function [Y_pred] = EM_(X,K,Method,iters,eps)
    [Pi,Mu] = initialization(X,K,Method);
    X = sparse(X);            % Because X is a binary vectorized dataset 
    [N,~] = size(X);
    r = zeros(N,K);
    for iter = 1:iters
        iter
        r_ = r;
        r = Estep(X,K,Pi,Mu);           % E-Step
        [Pi,Mu] = Mstep(X,r);           % M-Step
        if (r - r_ <= eps)              % Check convergence 
            break;
        end
    end
    [~,Y_pred] = max(r,[],2);
end