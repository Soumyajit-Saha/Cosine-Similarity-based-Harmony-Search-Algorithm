p=textread('C:/project/FER/hvn lbp/hvnlbpcoding_32_RAFD.csv','%s','bufsize',50000);
p=split(p,',');
[row,col]=size(p);
m1=p(2:row,col);
m1=m1';
p=p(2:row,1:col-1);
p=str2double(p);


ch=m1(:,1);
     count=1;
     count_in_class=0;
     for i=1:row-1
         if(strcmp(m1(1,i),ch)==1)
             count_in_class=count_in_class+1;
             ch=m1(1,i);
         else
             break;
         end
     end
     ch=m1(:,1);
     for i=1:row-1
         if(strcmp(m1(1,i),ch)~=1)
             count=count+1;
             ch=m1(1,i);
         end
         y(i)=count;
     end
     %m1=m1';
 %     p=p(2:row,1:col-1);
 %     p=str2double(p);
     train_ratio=0.66;
     test_ratio=0.34;
     train_arr=zeros(1,row-1);
     X_train=zeros(int32(train_ratio*count_in_class)*max(y),col-1);
     Y_train=zeros(int32(train_ratio*count_in_class)*max(y),1);
     X_test=zeros(int32((row-1)-int32(train_ratio*count_in_class)*max(y)),col-1);
     Y_test=zeros(int32((row-1)-int32(train_ratio*count_in_class)*max(y)),1);
     in1=1;
     in2=1;
     for cl=1:max(y)
         i=1;
         while(i<int32(train_ratio*(count_in_class))+1)
             inst=randi([(cl-1)*count_in_class+1,cl*count_in_class]);
             if(train_arr(1,inst)==1)
                 continue;
             else
                
             X_train(in1,:)=p(inst,:);
             Y_train(in1,:)=y(inst);
             train_arr(1,inst)=1;
             in1
             in1=in1+1;
             
             end
          i=i+1;   
         end
         i=1;
         while(i<int32(count_in_class-train_ratio*(count_in_class))+1)
             inst=randi([(cl-1)*count_in_class+1,cl*count_in_class]);
             if(train_arr(1,inst)==1)
                 continue;
             else
                 
             X_test(in2,:)=p(inst,:);
             Y_test(in2,:)=y(inst);
             train_arr(1,inst)=1;
             in2
             in2=in2+1;
             
            end
             i=i+1;
         end
    end
 m=X_train;
 m1=Y_train
 c=1;
 for k=1:col-1
     max_value=max(X_train(:,k));
     min_value=min(X_train(:,k));
     if((max_value-min_value)~=0)
         m(:,c)=p(:,k);
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
          
