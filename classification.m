 acc=zeros(15,2);
 for k=1:15
    str=sprintf('C:/project/FER/test_journal/ulbp_rafd_48/%d.csv',k);
%     str='C:/project/FER/test_journal/exp.csv';
    %str1=sprintf('/%d.csv',k);
%     acc=99;
%     while(acc>0.80)
%     str='C:/project/FER/hvn LBP/hvnlbpcoding_32_rafd.csv';
    XY=textread(str,'%s','bufsize',50000);
    XY=split(XY,',');
    [r,c]=size(XY);
    m1=XY(2:r,c);
%     ch=m1(1,:);
    count=1;
%     count_in_class=0;
%     for i=1:row-1
%         if(strcmp(m1(i,1),ch)==1)
%             count_in_class=count_in_class+1;
%             ch=m1(i,1);
%         else
%             break;
%         end
%     end
%     ch=m1(1,:);
%     for i=1:row-1
%         if(strcmp(m1(i,1),ch)~=1)
%             count=count+1;
%             ch=m1(i,1);
%         end
%         Y_train(i,:)=count;
%     end
    
%     %m1=m1';
    X_train=XY(2:r,1:c-1);
    X_train=str2double(X_train);
%     train_ratio=0.66;
%     test_ratio=0.34;
%     train_arr=zeros(1,row-1);
%     X_train=zeros(int32(train_ratio*(row-1)),col-1);
%     Y_train=zeros(int32(train_ratio*(row-1)),1);
%     X_test=zeros(int32((row-1)-train_ratio*(row-1)),col-1);
%     Y_test=zeros(int32((row-1)-train_ratio*(row-1)),1);
%     in1=1;
%     in2=1;
%     for cl=1:max(y)
%         i=1;
%         while(i<int32(train_ratio*(count_in_class))+1)
%             inst=randi([(cl-1)*count_in_class+1,cl*count_in_class]);
%             if(train_arr(1,inst)==1)
%                 continue;
%             end
%             X_train(in1,:)=p(inst,:);
%             Y_train(in1,:)=y(inst);
%             train_arr(1,inst)=1;
%             in1=in1+1;
%          i=i+1;   
%         end
%         i=1;
%         while(i<(count_in_class)-int32(train_ratio*(count_in_class))+1)
%             inst=randi([(cl-1)*count_in_class+1,cl*count_in_class]);
%             if(train_arr(1,inst)==1)
%                 continue;
%             end
%             X_test(in2,:)=p(inst,:);
%             Y_test(in2,:)=y(inst);
%             train_arr(1,inst)=1;
%             in2=in2+1;
%             i=i+1;
%         end
%     end
    class=zeros(1,max(Y_train));
    for i=1:max(Y_train)
        class(i)=i;
    end
    num=1;
    [tmp,~]=size(X_test);
    X_test1=zeros(tmp,sum(HM(k,:)==1));
    for i=1:col-1
        if(HM(k,i)==1)
            X_test1(:,num)=X_test(:,i);
            num=num+1;
        end
    end
            
    temp = templateSVM('Standardize',1,'KernelFunction','linear','Solver','SMO','KernelScale','auto');
    svmModel = fitcecoc(X_train,Y_train,'Learners',temp,'ClassNames',class,'Coding','onevsall');
    [label,~] = predict(svmModel,X_test1);
    [rw,co]=size(X_test1);
    c = sum(Y_test ~= label)/rw;
    performance=1-c;
%     acc=performance;
    acc(k,2)=performance;
    acc(k,1)=co;
end
acc
