%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mixture of Gaussian contour Plot                                               

function out=plot_figure(x_data,iter,visual,mu,sigma,r)    
    n=length(x_data);
    subplot(ceil(sqrt(length(visual))),ceil(sqrt(length(visual))),find(visual==iter))
    G = gmdistribution(mu,sigma);
    F = @(x,y) pdf(G,[x y]);
    soft_ass = [r(:,1), zeros(n, 1), r(:,2)]; % fraction of red and blue   
    for i=1:n
        plot(x_data(i, 1), x_data(i, 2), 'o', 'MarkerSize', 4, 'MarkerFaceColor', soft_ass(i, :), 'MarkerEdgeColor', 'k');
        hold on
    end
   
    hold on  
    mu1 = mu(1,:)';
    [U, D] = eig(sigma(:,:,1));
    ni = 100;
    t = linspace(0, 2*pi, ni);
    xy = [cos(t); sin(t)];
    k = sqrt(chi2inv(0.95, 2)); % 5.99
    %k = sqrt(6);
    w = (k * U * sqrt(D)) * xy;
    z = repmat(mu1, [1 ni]) + w;
    h = plot(z(1, :), z(2, :), 'color', 'r', 'linewidth', 1);
    hold on
    plot(mu1(1), mu1(2),  'x','markersize', 5,'color', 'r');
    xlim([-4,4]);
    mu2 = mu(2,:)';
    [U, D] = eig(sigma(:,:,2));
    ni = 100;
    t = linspace(0, 2*pi, ni);
    xy = [cos(t); sin(t)];
    k = sqrt(chi2inv(0.95, 2)); % 5.99
    %k = sqrt(6);
    w = (k * U * sqrt(D)) * xy;
    z = repmat(mu2, [1 ni]) + w;
    h = plot(z(1, :), z(2, :), 'color', 'b', 'linewidth', 1);
    hold on
    plot(mu2(1), mu2(2),  'x','markersize', 5,'color', 'b');
    xlim([-4,4]);
    out=1;
    title(['iteration number ',num2str(iter),' .']);
end
