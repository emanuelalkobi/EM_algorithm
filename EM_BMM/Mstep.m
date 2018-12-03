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
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
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