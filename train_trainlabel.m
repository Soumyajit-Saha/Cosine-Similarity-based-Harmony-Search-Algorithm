function [ accuracy ] = train_trainlabel( str )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
m=textread(str,'%s');
m=split(m,',');
[row,col]=size(m);
ch=m(1,col);
count=1;
for i=1:row
    if(strcmp(m(i,col),ch)~=1)
        count=count+1;
        ch=m(i,col);
    end
    temp(i)=count;
end

m=m(:,1:col-1);
m=str2double(m);
% csvwrite('./pca.csv',m);
% %m=py.pca.principle();
% py.pca.principle();
for i=1:row
    z(i,1)=i;
end
m=[z m(:,:)];
csvwrite('./nh.csv',m);
fp=fopen('./nhlvl.csv','w');
i=1;
while(i<row+1)
    fprintf(fp,'%d,',i);
    fprintf(fp,'%d\n',temp(i));
    i=i+1;
end
fclose(fp);
accuracy=py.fedup.main();
end

