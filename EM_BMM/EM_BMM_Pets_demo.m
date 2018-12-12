function EM_BMM_Pets_demo()
%% Load Pets Data
[Xt,Yt] = read_data();
Xt = Xt./max(max(Xt));

%% Binarizing data Set
t = 0.50;
Xt(Xt >= t) = 1;
Xt(Xt < t) = 0;

% Xtr(Xtr >= t) = 1;
% Xtr(Xtr < t) = 0;

%% EM_BMM
% rng('default')

% Training EM for BMM on Xt: Train Parameters
k = 4;                         % assuming 10 forms of digits (WRONG!!)
iters = 500;
eps = 10^(-8);
M1 = 'random';
% M2 = 'data_random'; Can't use it on a bbinary data set
M3 = 'k_means';

%% Training Random Initialization (without Prior)
tic % iters converges 80, Run time = 40 sec k =2; 80, 34, k = 4
[~,Mdl] = EM(Xt,k,M1,iters,eps);
Pi_data_rnd = Mdl.Pi;
Mu_data_rnd = Mdl.Mu;
toc

%% Training k-means Data Initialization (without Prior)
tic % iters converge at 16, Run time = 10 sec k =2; 16, 8, k=4
[~,Mdl] = EM(Xt,k,M3,iters,eps);
Pi_data_kmeans = Mdl.Pi;
Mu_data_kmeans = Mdl.Mu;
toc

%% Outputs
%% Random (without Prior)
figure(1)
for i = 1:k
subplot(2,round(k/2),i)
imshow(reshape(Mu_data_rnd(i,:),64,64));
colormap('gray');
title(sprintf('%1.2f', Pi_data_rnd(i)), 'fontsize', 35);
axis off
end

%% k-means (without Prior)
figure(2)
for i = 1:k
subplot(2,round(k/2),i)
imshow(reshape(Mu_data_kmeans(i,:),64,64));
colormap('gray');
title(sprintf('%1.2f', Pi_data_kmeans(i)), 'fontsize', 25);
axis off
end
end