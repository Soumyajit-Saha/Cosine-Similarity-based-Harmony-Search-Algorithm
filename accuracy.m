function [ score ] = accuracy( X,m1,m )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    f1=fopen('feat.csv','w');
    for i1=1:15000
        for c=1:389
        if(X(:,c)==1)
           fprintf(f1,'%f,',m(i1,c));
        end
        end
           %fprintf(f1,'%f\n',temp(i1,cx));
           fprintf(f1,'%s\n',m1{:,i1});
    end
    fclose(f1);
    display('feature file created');
    score=train_trainlabel('feat.csv');



end

