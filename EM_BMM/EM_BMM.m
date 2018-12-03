function EM_BMM()
    clc
    rng('default');
    
    %% Load MNIST Data Set
    %Dtr = load('data_mnist_train.mat');
    Dt = load('data_mnist_test.mat');
    %Xtr = Dtr.X_train;
    Xt = Dt.X_test;
    Yt = Dt.Y_test;
    
    %% Pre-Processing: Binarizing the data set to values 0 and 1
    %Xtr(Xtr ~= 0) = 1;
    Xt(Xt ~= 0) = 1;
    
    %% Training EM for BMM on Xt
    k = 10;                         % assuming 10 forms of digits (WRONG!!)
    iters = 100;
    eps = 10^(-8);
    M1 = 'random';
    M2 = 'data_random';
    M3 = 'k_means';
    %%
    Ypred_rnd = EM_(Xt,k,M1,iters,eps);
    %%
    Ypred_d_rnd = EM_(Xt,k,M2,iters,eps);
    %%
    Ypred_kmeans = EM_(Xt,k,M3,iters,eps);
    
    %% Test Accuracy: CCR Metric (Should be low)
%     CCR_rnd = label_clustering_ccr(Ypred_rnd,k,Yt);
%     CCR_d_rnd = label_clustering_ccr(Ypred_d_rnd,k,Yt);
%     CCR_kmeans = label_clustring_ccr(Ypred_kmeans,k,Yt); 
figure(1)
[s,h] = silhouette(Xt,Ypred_kmeans)
title('silhouette for clustering')
end