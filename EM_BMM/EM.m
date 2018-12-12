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
function [Y_pred,Model] = EM(X,K,Method,iters,eps)
    %% Initialize and Get Data Parameters
    [Pi,Mu] = initialization(X,K,Method);
    X = sparse(X);                      % Because X_i is binary bit string
    [N,D] = size(X);
    
    %% Start The Algorithm
    sprintf('EM Algorithm Running /*****...')
    
    %% Report, Model, CCR, @ iteration: 'iter'
    Mdl = zeros(K,D+1,iters);
    % Responsibility matrix for E-Step
    r = zeros(N,K);
    % The E-M Algorithm
    for iter = 1:iters
        iter
        theta_ = [Pi',Mu];                            % old Theta
        r = Estep(X,Pi,Mu);                           % E-Step
        [Pi,Mu] = Mstep(X,r);                         % M-Step
        theta = [Pi',Mu];                             % New Theta
        % If NaN is estimated, Values underflew; Report Error
%         if (isnan(theta))
%             error('Estimates underflow Error; change cluster size or initialization');
%         end
        % If the New Theta is eps close to old Theta, EM has converged
        if (abs(theta-theta_) <= eps)                 % Check convergence 
            break;
        end
        % Save Model parameters, CCR, Convergence Iteration
        Mdl(:,:,iter) = theta;
        convergence_iter = iter;
    end
    [~,Y_pred] = max(r,[],2);
    Model.Pi = Pi;
    Model.Mu = Mu;
    Model.iters = Mdl;
    Model.convergence = convergence_iter;
end