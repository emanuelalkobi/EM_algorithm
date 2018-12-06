function [samples,labels] = process_data_adult()
%PROCESS_DATA_ADULT function process the next data set:
%%http://archive.ics.uci.edu/ml/datasets/Adult
%%it makes a matrix named data which each row represent a sample and each
%%column represent a feature.All the missing samples are removing from our
%%data.
    aduld_data=readtable('adult_data.txt','Delimiter',',','Format','%f%s%f%s%f%s%s%s%s%s%f%f%f%s%s');
    data=zeros(size(aduld_data));
    %%delete all points that have a missing data('?')
    size(aduld_data)
    toDelete = aduld_data.Var1 =='?' ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var2 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = aduld_data.Var3 =='?' ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var4 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = aduld_data.Var5 =='?' ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var6 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var7 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var8 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var9 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var10 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = aduld_data.Var11 =='?' ;
    aduld_data(toDelete,:) = [];
    toDelete = aduld_data.Var12 =='?' ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var13 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var14 ,'?') ;
    aduld_data(toDelete,:) = [];
    toDelete = strcmp(aduld_data.Var15 ,'?') ;
    aduld_data(toDelete,:) = [];
    size_data=size(aduld_data);
    data=zeros(size_data);
    data_len=(size_data(1))
    %%
    %%
    %%process the data 
    %continious features:age,fnlwgt,education-num,capital-gain,capital-loss,hours-per-week
    data(:,1)=table2array(aduld_data(:,1));
    data(:,3)=table2array(aduld_data(:,3));
    data(:,5)=table2array(aduld_data(:,5));
    data(:,11)=table2array(aduld_data(:,11));
    data(:,12)=table2array(aduld_data(:,12));
    data(:,13)=table2array(aduld_data(:,13));


    %workclass
    workclass_key = {'Private', 'Self-emp-not-inc', 'Self-emp-inc', 'Federal-gov', 'Local-gov', 'State-gov','Without-pay', 'Never-worked'};
    workclass_num=size(workclass_key);
    workclass_value = [1:1:workclass_num(2)];
    workclass_dict=containers.Map(workclass_key,workclass_value);

    %education
    education_key={'Bachelors', 'Some-college', '11th', 'HS-grad', 'Prof-school', 'Assoc-acdm', 'Assoc-voc', '9th', '7th-8th', '12th', 'Masters','1st-4th', '10th', 'Doctorate', '5th-6th', 'Preschool'}
    education_num=size(education_key);
    education_value = [1:1:education_num(2)];
    education_dict=containers.Map(education_key,education_value);

    %marital-status
    marital_key={'Married-civ-spouse', 'Divorced', 'Never-married', 'Separated', 'Widowed', 'Married-spouse-absent', 'Married-AF-spouse'}
    marital_num=size(marital_key);
    marital_value = [1:1:marital_num(2)];
    marital_dict=containers.Map(marital_key,marital_value);

    %occupation
    occupation_key={'Tech-support', 'Craft-repair', 'Other-service', 'Sales', 'Exec-managerial', 'Prof-specialty', 'Handlers-cleaners', 'Machine-op-inspct', 'Adm-clerical', 'Farming-fishing', 'Transport-moving', 'Priv-house-serv', 'Protective-serv', 'Armed-Forces'}
    occupation_num=size(occupation_key);
    occupation_value = [1:1:occupation_num(2)];
    occupation_dict=containers.Map(occupation_key,occupation_value);



    %relationship
    relationship_key={'Wife', 'Own-child', 'Husband', 'Not-in-family', 'Other-relative', 'Unmarried'}
    relationship_num=size(relationship_key);
    relationship_value = [1:1:relationship_num(2)];
    relationship_dict=containers.Map(relationship_key,relationship_value);

    %race
    race_key={'White', 'Asian-Pac-Islander', 'Amer-Indian-Eskimo', 'Other', 'Black'}
    race_num=size(race_key);
    race_value = [1:1:race_num(2)];
    race_dict=containers.Map(race_key,race_value);

    %sex
    sex_key={'Female', 'Male'}
    sex_num=size(sex_key);
    sex_value = [1:1:sex_num(2)];
    sex_dict=containers.Map(sex_key,sex_value);

    %country
    country_key={'United-States', 'Cambodia', 'England', 'Puerto-Rico', 'Canada', 'Germany', 'Outlying-US(Guam-USVI-etc)', 'India', 'Japan', 'Greece', 'South','China', 'Cuba', 'Iran', 'Honduras', 'Philippines', 'Italy', 'Poland', 'Jamaica', 'Vietnam', 'Mexico', 'Portugal', 'Ireland', 'France', 'Dominican-Republic', 'Laos', 'Ecuador', 'Taiwan', 'Haiti', 'Columbia','Hungary', 'Guatemala', 'Nicaragua', 'Scotland', 'Thailand', 'Yugoslavia', 'El-Salvador', 'Trinadad&Tobago', 'Peru', 'Hong', 'Holand-Netherlands'};
    country_num=size(country_key);
    country_value = [1:1:country_num(2)];
    country_dict=containers.Map(country_key,country_value);

    %label
    label_key={'<=50K','>50K'}
    label_num=size(label_key);
    label_value = [1:1:label_num(2)];
    label_dict=containers.Map(label_key,label_value);

    for i=1:data_len

        data(i,2)=workclass_dict(char(table2array(aduld_data(i,2))));
        data(i,4)=education_dict(char(table2array(aduld_data(i,4))));
        data(i,6)=marital_dict(char(table2array(aduld_data(i,6))));
        data(i,7)=occupation_dict(char(table2array(aduld_data(i,7))));
        data(i,8)=relationship_dict(char(table2array(aduld_data(i,8))));
        data(i,9)=race_dict(char(table2array(aduld_data(i,9))));
        data(i,10)=sex_dict(char(table2array(aduld_data(i,10))));
        data(i,14)=country_dict(char(table2array(aduld_data(i,14))));
        data(i,15)=label_dict(char(table2array(aduld_data(i,15))));

    end


    %creating saples matrix(size of [num of samples by 14]
    samples=data(:,1:14);

    %creating samples vector(size of [num of samples]
    labels=data(:,15);

end

