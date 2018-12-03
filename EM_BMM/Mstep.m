%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : Mstep                                                       %  
% Inputs    : X     - The n data points in R^d size (n*d)                 %
%             r      - output of the EM algorithm Expectation part.       %
%                      r will be of size of n*K and it will hold the      %
%                      probability for each class.                        %
% Outputs   :                                                             %
%             Pi      - Vector of length K w/ prior prob. of each class   %                                                    %
%             Mu      - Matrix of K mean value for each class. (k*d)      %
%                                                                         %
%                                                                         %
%                                                                         %  

function [Pi,Mu] = Mstep(X,r)
    X = sparse(X);
    [~,D] = size(X);
    [N,K] = size(r);
    % Parameter Estimation (ML)
    N_k = sum(r);
    Pi = N_k./N;                            % Pi ML estimate = N_k/N
    Mu_ = zeros(K,D);
    for k=1:K
        Mu_(k,:) = sum(r(:,k).*X)/N_k(k);    % Mu = r weighted Mean of X
    end
    Mu = Mu_;
end