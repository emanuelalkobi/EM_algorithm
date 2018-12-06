%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mixture of Gaussian contour Plot                                               

function out=plot_figure(x_data,iter,visual,mu,sigma)    
    subplot(ceil(sqrt(length(visual))),ceil(sqrt(length(visual))),find(visual==iter))
    G = gmdistribution(mu,sigma);
    F = @(x,y) pdf(G,[x y]);
    plot(x_data(:,1),x_data(:,2),'k.','MarkerSize',2);
    hold on
    out=ezcontour(F);
    title(['iteration number ',num2str(iter),' .']);
end
