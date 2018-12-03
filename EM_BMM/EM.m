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
%             eps        - Convergence threshold (Not Used)               %
% Outputs   :                                                             %
%             Y_Pred     - n*1 vector. It is the predicted Cluster Label  %
%                                                                         %
%                                                                         %  

function [Y_pred] = EM(X,K,method,iters,eps)
%     [N,~] = size(X);
    [Pi,Mu]=initialization(X,K,method);    % Parameter Initialization
    X = sparse(X);
    
%     Pred = zeros(N,1);
    for iter=1:iters
        tic
        iter
%         prev_Pred = Pred;                       % Y @ t-1
        r = Estep(X,K,Pi,Mu);                   % E-Step
        [Pi,Mu] = Mstep(X,r);                   % M-Step
%         [~,Pred] = max(r,[],2);                 % Y @ t
%         if ((prev_Pred - Pred) <= eps)
%             break;
%         end
        toc
    end
    [~,Y_pred] = max(r,[],2);
end