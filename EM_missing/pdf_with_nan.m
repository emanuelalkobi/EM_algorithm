%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : pdf_with_nan                                              %
% Inputs    : x_data     - The n data points in R^d size (total sizen*d)  %
%           : K - Number of different classes.                            %
%             mu      - Matrix of K mean value for each class.            %
%             sigma   - K covariance matrixes                             %
% Outputs   :                                                             %
%             pdf_estimated- output is n*k matrix with for each data point% 
%             it computes the normal pdf value with mean mu and variance  %
%             sigma of  the current data point for class k.               %
%             For Nan values-missing data points it calculate the pdf     %
%             over the marginal distribution  of the observe points       %
%             (There must be at least one observed feature for each data  %
%             point as we deleted all the rows that have no observed      %
%             features                                                    %
                                                                       %  

function [pdf_estimated] = pdf_with_nan(x_data,K,mu,sigma)
%PDF_WITH_NAN Summary of this function goes here
%   Detailed explanation goes here
[n,d]=size(x_data);
data_observed = sum(isnan(x_data),2)==0;
pdf_estimated = zeros(n,K);

for i = 1:K
    pdf_estimated(data_observed,i) = mvnpdf(x_data(data_observed,:),mu(i,:),sigma(:,:,i));
end


miss_data_idx = find(sum(isnan(x_data),2)>0);
for i = 1:length(miss_data_idx)
    features_observed = ~isnan(x_data(miss_data_idx(i),:));
    for j = 1:K
        pdf_estimated(miss_data_idx(i),j) = mvnpdf(x_data(miss_data_idx(i),features_observed),mu(j,features_observed),sigma(features_observed,features_observed,j));
    end
end


end

