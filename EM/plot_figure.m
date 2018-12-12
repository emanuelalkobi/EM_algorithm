%% EC 503: Learning from Data                                            %% 
%% Boston University                                                     %%  
%% Fall 2018, ProjectAXE                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mixture of Gaussian soft assignment and error ellipse Plot                                               

function out=plot_figure(x_data,iter,visual,mu,sigma,r)    
    n=length(x_data);
    ni = 100;
    subplot(ceil(sqrt(length(visual))),ceil(sqrt(length(visual))),find(visual==iter))
    soft_ass = [r(:,1), zeros(n, 1), r(:,2)];   
    for i=1:n
        plot(x_data(i, 1), x_data(i, 2), '.', 'MarkerSize', 5, 'Markeredgecolor', soft_ass(i, :));
        hold on
    end
    
    hold on  
    mu1=mu(1,:)';
    mu2=mu(2,:)';
    x=0:2*pi/99:2*pi;
    y=[cos(x); sin(x)];
    [A1, B1]=eig(sigma(:,:,1)); 
    [A2, B2]=eig(sigma(:,:,2));
    temp=zeros(2,ni);
    temp(1,:)=mu1(1,:);
    temp(2,:)=mu1(2,:);
    ellipse1=temp+(sqrt(chi2inv(0.95, 2))*A1*sqrt(B1))*y;
    plot(mu1(1), mu1(2),  'x','markersize', 5,'color', 'r');
    hold on
    plot(ellipse1(1, :), ellipse1(2, :), 'color', 'r', 'linewidth', 1);
    hold on
    xlim([-5,5]);
    ylim([-4,4]);
    temp2=zeros(2,ni);
    temp2(1,:)=mu2(1,:);
    temp2(2,:)=mu2(2,:);
    ellipse2=temp2+(sqrt(chi2inv(0.95, 2))*A2*sqrt(B2))*y;
    plot(mu2(1), mu2(2),  'x','markersize', 5,'color', 'b');
    hold on
    plot(ellipse2(1, :), ellipse2(2, :), 'color', 'b', 'linewidth', 1);
    xlim([-5,5]);
    ylim([-4,4]);
    out=1;
    title(['iteration number ',num2str(iter),' .']);
end
