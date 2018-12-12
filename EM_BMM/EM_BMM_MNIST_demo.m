function EM_BMM_MNIST_demo()
%% Load Data
% Xtr = loadMNISTImages('train-images-idx3-ubyte')';
Xt = loadMNISTImages('MNIST/t10k-images-idx3-ubyte')';
% Yt = loadMNISTLabels('MNIST/t10k-labels-idx1-ubyte');
%% Binarizing data Set
t = 0.10;
Xt(Xt >= t) = 1;
Xt(Xt < t) = 0;

% Xtr(Xtr >= t) = 1;
% Xtr(Xtr < t) = 0;

%% EM_BMM
clc
rng('default')

% Training EM for BMM on Xt: Train Parameters
k = 15;                         % assuming 10 forms of digits (WRONG!!)
iters = 500;
eps = 10^(-8);
M1 = 'random';
% M2 = 'data_random'; Can't use it on a bbinary data set
M3 = 'k_means';

%% Training Random Initialization (without Prior)
tic % iters converge at 339, Run time = 125 sec
[~,Mdl] = EM(Xt,k,M1,iters,eps);
Pi_data_rnd = Mdl.Pi;
Mu_data_rnd = Mdl.Mu;
toc

%% Training k-means Data Initialization (without Prior)
tic % iters converge at 142, Run time = 56 sec
[~,Mdl] = EM(Xt,k,M3,iters,eps);
Pi_data_kmeans = Mdl.Pi;
Mu_data_kmeans = Mdl.Mu;
toc

%% Outputs
%% Random (without Prior)
figure(1)
for i = 1:k
subplot(2,round(k/2),i)
imshow(reshape(Mu_data_rnd(i,:),28,28));
colormap('gray');
title(sprintf('%1.2f', Pi_data_rnd(i)), 'fontsize', 35);
axis off
end

%% k-means (without Prior)
figure(2)
for i = 1:k
subplot(2,round(k/2),i)
imshow(reshape(Mu_data_kmeans(i,:),28,28));
colormap('gray');
title(sprintf('%1.2f', Pi_data_kmeans(i)), 'fontsize', 25);
axis off
end

end