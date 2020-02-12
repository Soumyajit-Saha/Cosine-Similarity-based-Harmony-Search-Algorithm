acc=zeros(15,2);
for k=1:15
    str=sprintf('C:/project/FER/test/ulbp_rafd_48/%d.csv',k);
    p=textread(str,'%s','bufsize',50000);
    p=split(p,',');
    [row,col]=size(p);
    m1=p(2:row,col);
    ch=m1(1,:);
    count=1;
    for i=1:row-1
        if(strcmp(m1(i,1),ch)~=1)
            count=count+1;
            ch=m1(i,1);
        end
        y(i)=count;
    end

    %m1=m1';
    p=p(2:row,1:col-1);
    p=str2double(p);
    train_ratio=0.66;
    test_ratio=0.34;
    train_arr=zeros(1,row-1);
    X_train=zeros(int32(train_ratio*(row-1)),col-1);
    Y_train=zeros(int32(train_ratio*(row-1)),1);
    X_test=zeros(int32(test_ratio*(row-1)),col-1);
    Y_test=zeros(int32(test_ratio*(row-1)),1);

    for i=1:int32(train_ratio*(row-1))
        inst=randi([1,row-1]);
        if(train_arr(1,inst)==1)
            continue;
        end
        X_train(i,:)=p(inst,:);
        Y_train(i,:)=y(inst);
    end
    for i=1:(row-1)-int32(train_ratio*(row-1))
        inst=randi([1,row-1]);
        if(train_arr(1,inst)==1)
            continue;
        end
        X_test(i,:)=p(inst,:);
        Y_test(i,:)=y(inst);
    end
    class=zeros(1,max(y));
    for i=1:max(y)
        class(i)=i;
    end
    temp = templateSVM('Standardize',1,'KernelFunction','Gaussian','Solver','SMO','KernelScale','auto');
    svmModel = fitcecoc(X_train,Y_train,'Learners',temp,'ClassNames',class,'Coding','onevsall');
    [label,~] = predict(svmModel,X_test);
    [rw,co]=size(X_test);
    c = sum(Y_test ~= label)/rw;
    performance=1-c;
    acc(k,2)=performance;
    acc(k,1)=co;
end
acc