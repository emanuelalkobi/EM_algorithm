function [samples,labels,animals_name] = process_data_zoo()
%PROCESS_DATA_ADULT function process the next data set:
%%http://archive.ics.uci.edu/ml/datasets/zoo
%%it makes a matrix named data which each row represent a sample and each
%%column represent a feature.there are 16 features for each animal and it
%%can belongs to one of 7 classes.
%%

    zoo_data=readtable('zoo.data.txt');
    size_data=size(zoo_data);
    data=zeros(size_data(1),size_data(2)-1);
    data(:,:)=table2array(zoo_data(:,2:18));
    animals_name=zoo_data(:,1);
    samples=data(:,1:16);
    labels=data(:,17);

end

