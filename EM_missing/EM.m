%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function  : EM algorithms                                               %
% Inputs    : x_data- n*d matrix .n-number of samples , d-dimension       %
%             of samples                                                  %
%             K          - Number of different classes.                   %
%             method     - The way to initialize the parameters:          %
%             random     -Choose completly random values for the mean of  %
%             clasess.                                                    %
%             data_random-Choose K random points from X_data to be the    %
%             initial mean of clasess.                                    %
%             k_means-Use k means algorith for initial all the output     %
%             parameters.                                                 %
%             iter-number of iterations to run the EM algorith            % 
%             diff-the difference between 2 consecutive iterations than   %
%             is  less than diff value  will stop the EM algorithm        %     
% Outputs   :                                                             %
%             y_predicted-n*1 vector.It is the predicted  labels for      %
% Variable Naming Convention: (var)_(property); pt--point, C--cluster     %
%                                                                         %
%                                                                         %  

function [y_predicted] = EM(x_data,K,method,iters,diff)
    %initialization
    %number of dimension for each data point 
    [n,d]=size(x_data);
    
    [pi,mu,sigma]=initialization(x_data,K,method);

    %%
    obj_fun=zeros(1,iters+1);;

    for iter=1:iters
        %iter
        obj_fun(iter);
        % E-step
        [r,miss_data_expected,sigma_inv]=e_step(x_data,K,pi,mu,sigma);
        % M-step
        [pi,mu,sigma,obj_fun(iter+1)]=m_step(x_data,K,r,miss_data_expected,sigma_inv);
        [~,predicted]=max(r,[],2);
        %obj_fun(iter+1)=sum(log(mvnpdf(x_data,mu(predicted,:),sigma(:,:,predicted)))); 

        if abs((obj_fun(iter+1)-obj_fun(iter))/obj_fun(iter+1))<diff;
            %fprintf('Optimization converged after %d iterations .\n',iter);
            break
        end
    end
    [~,y_predicted]=max(r,[],2);

end

