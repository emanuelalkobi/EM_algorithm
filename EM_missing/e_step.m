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
%             miss_data_expected-the expected data value of the missing   %
%                                 data                                    %
%             sigma_inv-The inverse of the covariance matrix.             %
%                       Necessary for the A_nk at the M step              %
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  

function [r,miss_data_expected,sigma_inv] = e_step(x_data,K,pi,mu,sigma)
%E_STEP Summary of this function goes here
%   Detailed explanation goes here
    miss_data_idx = find(sum(isnan(x_data),2)>0);
    Nan_num = sum(sum(isnan(x_data)));
    pdf_est=pdf_with_nan(x_data,K,mu,sigma);
    for k=1:K       
            p(:,k)=pi(k)*pdf_est(:,k);        
    end
    r=p./sum(p,2);
    
    if length(miss_data_idx) > 0
        for i = 1:K
            sigma_inv(:,:,i) = inv(sigma(:,:,i));
        end
    else
        sigma_inv=0;
    end
    
    miss_data_expected=zeros(Nan_num,3,K);
    for i = 1:K
    c=1;
        for j = 1:length(miss_data_idx)
            %calc the expected value of the missing data
            features_observed = ~isnan(x_data(miss_data_idx(j),:));
            features_miss = ~features_observed;
            total_miss=sum(features_miss);
            mm_mo = inv((sigma_inv(features_miss,features_miss,i)))*(sigma_inv(features_miss,features_observed,i));
            miss_data_expected(c:c+total_miss-1,1,i)=miss_data_idx(j);
            miss_data_expected(c:c+total_miss-1,2,i)= find(features_miss);
            miss_data_expected(c:c+total_miss-1,3,i)=mu(i,features_miss)'-mm_mo*(x_data(miss_data_idx(j),features_observed)-mu(i,features_observed))';;
            c=c+total_miss;
        end
    end


    
end

