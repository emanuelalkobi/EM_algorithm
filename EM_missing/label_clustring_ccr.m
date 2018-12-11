function [best_ccr] = label_clustring_ccr(clusters_labels,cluster_num,labels)
%LABEL_CLUSTRING_CCR compute the ccr for a label data after clustring it .
%it compute all the possible permuatations of the labels.


    groups=[1:1:cluster_num];
    p = perms(groups);
    size_p=size(p);
    original_clusters=clusters_labels;
    ccr=zeros(size_p(1),1);
    for i=1:size_p(1)
        clusters=original_clusters;
        new_cluster=zeros(size(labels));
        old_code=groups;
        new_code=p(i,:);
        [a,b] = ismember(clusters,old_code);
        clusters(a) = new_code(b(a));
        Con_out=confusionmat(labels,clusters);
        ccr(i)=trace(Con_out)/sum(sum(Con_out)) ; 
    end
    
best_ccr=max(ccr);
end

