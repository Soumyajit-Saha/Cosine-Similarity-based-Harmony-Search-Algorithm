p=textread('C:/project/FER/hvn lbp/hvnlbpcoding_32_RAFD.csv','%s','bufsize',50000);
p=split(p,',');
[row,col]=size(p);
m1=p(2:row,col);
m1=m1';
p=p(2:row,1:col-1);
p=str2double(p);

count=1;
ch=m1(:,1);
     for i=1:row-1
         if(strcmp(m1(1,i),ch)~=1)
             count=count+1;
             ch=m1(1,i);
         end
         y(i)=count;
     end
     
rng('default');
% Cross varidation (train: 70%, test: 30%)
cv = cvpartition(size(p,1),'HoldOut',0.34);
idx = cv.test;
% Separate to training and test data
X_train = p(~idx,:);
Y_train = y(~idx);
X_test  = p(idx,:);
Y_test = y(idx);

m=X_train;
m1=Y_train;
 c=1;
 for k=1:col-1
     max_value=max(X_train(:,k));
     min_value=min(X_train(:,k));
     if((max_value-min_value)~=0)
         m(:,c)=X_train(:,k);
         c=c+1;
     end
 end
[row,col]=size(m);
row=row+1;
col=col+1;
sim_mat=zeros(col-1,col-1);
p=zeros(row-1,col-1);
for j=1:col-1
    max_value=max(m(:,j));
    min_value=min(m(:,j));
    p(:,j)=(m(:,j)-min_value)/(max_value-min_value);
end
for i=1:col-1
    for j=1:col-1
        sim_mat(i,j)=CosineSimilarity(p(:,i),p(:,j));
    end
end
