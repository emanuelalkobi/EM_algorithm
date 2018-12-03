%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : EM algorithms                                               %
% Inputs    : X          - n*d matrix .n-number of samples , d-dimension  %
%             K          - Number of different classes.                   %
%             Method     - The way to initialize the parameters:          %
%             'random'   - Choose completly random values for the mean of %
%                          clasess.                                       %
%             'data_random' - Choose K random points from X_data to be the%
%                             initial mean of clasess.                    %
%             'k_means'  - Use k means algorith for initial all the output%
%                          parameters.                                    %
%             iter       - Number of iterations to run the EM algorith    % 
%             eps        - Convergence threshold (Used)                   %
% Outputs   :                                                             %
%             Y_Pred     - n*1 vector. It is the predicted Cluster Label  %
%                                                                         %
%                                                                         %  
function [Y_pred] = EM_(X,K,Method,iters,eps)
    [Pi,Mu] = initialization(X,K,Method);
    X = sparse(X);            % Because X is a binary vectorized dataset 
    [N,~] = size(X);
    r = zeros(N,K);
    for iter = 1:iters
        r_ = r;
        r = Estep(X,K,Pi,Mu);           % E-Step
        [Pi,Mu] = Mstep(X,r);           % M-Step
        if (r - r_ <= eps)              % Check convergence 
            break;
        end
    end
    [~,Y_pred] = max(r,[],2);
end