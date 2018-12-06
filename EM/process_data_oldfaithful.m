function [x_data] = process_data_oldfaithful()
%PROCESS_data)oldfaithful function process the next data set:
%%https://www.stat.cmu.edu/~larry/all-of-statistics/=data/faithful.dat
%%it makes a matrix named data which each row represent a sample and each
%%column represent a feature.there are 2 features for each example and it
%%can belongs to one of 2 classes.
%%
x_data=csvread('OldFaithful.csv');
[n,d]=size(x_data);
x_data(:,1) = x_data(:,1) - min(x_data(:,1));  
x_data(:,1) = 4.*x_data(:,1) / max(x_data(:,1));
x_data(:,2) = x_data(:,2) - min(x_data(:,2));  
x_data(:,2) = 4.*x_data(:,2) / max(x_data(:,2));
x_data(:,1) = x_data(:,1)-2;
x_data(:,2) = x_data(:,2)-2;

end