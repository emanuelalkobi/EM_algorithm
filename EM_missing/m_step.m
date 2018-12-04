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
%             miss_data_expected-the expected data value of the missing   %
%                                 data                                    %
%             sigma_inv-The inverse of the covariance matrix.             %
%                       Necessary for the A_nk at the M step              %
% Outputs   :
%             pi      - Vector of length K with prior probabilty for each %
%             class                                                       %
%             mu      - Matrix of K mean value for each class.            %
%             sigma   - K covariance matrixes      
%             obj_fun - the value of the object funtion at the current    %
%             iteration                                                   %
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  

function [pi,mu,sigma,obj_fun] = m_step(x_data,K,r,miss_data_expected,sigma_inv)
    [n,d]=size(x_data);
    [n1,d1,~]=size(miss_data_expected);
    pi=sum(r)/n;
    x_filled = x_data;
    is_missing_data=sum(isnan(x_data(:))) > 0;
    for k=1:K
        if is_missing_data
            for j=1:n1
                row=miss_data_expected(j,1,k);
                col=miss_data_expected(j,2,k);
                x_filled(row,col) = miss_data_expected(j,3,k);
            end
        end
        mu(k,:)=sum(r(:,k).*x_filled)./sum(r(:,k));
        numerator=0;
        for i=1:n
        numerator=r(i,k).*(x_filled(i,:)'*x_filled(i,:))+numerator;
        end
        sigma(:,:,k)=(numerator./sum(r(:,k)))-mu(k,:)'*mu(k,:);
        sigma(:,:,k)=sigma(:,:,k)+ 0.0001*eye(d);
    end

    if is_missing_data
        miss_data_idx = find(sum(isnan(x_data),2)>0);   
        for i = 1:K
            for j = 1:length(miss_data_idx)
                features_miss = isnan(x_data(miss_data_idx(j),:));;
                sigma(features_miss,features_miss,i) = sigma(features_miss,features_miss,i) + (1/sum(r(:,i)))*r(miss_data_idx(j),i)*inv(sigma_inv(features_miss,features_miss,i));
            end
    	end

    end
    [~,y_predicted]=max(r,[],2);
    pdf_est=pdf_with_nan(x_data,K,mu,sigma);
    tmp=zeros(n,1);
    for i=1:n
        tmp(i)=pdf_est(i,y_predicted(i));
    end
    obj_fun=sum(log((tmp))); 

    

end

