%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : e_step                                              %
% Inputs    : x_data     - The n data points in R^d size (total sizen*d)  %
%           : K - Number of different classes.                            %
%             pi      - Vector of length K with prior probabilty for each %
%             class                                                       %
%             mu      - Matrix of K mean value for each class.            %
%             sigma   - K covariance matrixes                             %
% Outputs   :                                                             %
%             r      - output of the EM algorithm Expectation part.       %
%                      r will be of size of n*K and it will hold the      %
%                      probability for each class.                        %
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  

function [r] = e_step(x_data,K,pi,mu,sigma)
%E_STEP Summary of this function goes here
%   Detailed explanation goes here
    for k=1:K
            
            p(:,k)=pi(k)*mvnpdf(x_data,mu(k,:),sigma(:,:,k)); 
    end
    r=p./sum(p,2);
end

