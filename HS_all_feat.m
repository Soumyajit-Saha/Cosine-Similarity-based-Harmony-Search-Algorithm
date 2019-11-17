HM=X;
HMCR=0.7;
PAR=0.3;
it=1;
HMS=10;
acc=zeros(10,1);
for hi=1:10
    acc(hi,:)=accuracy(HM(hi,:),m1,m);
    display(acc(hi,:));
end

while(it<10)
    display(it);
    i=1;
    while(i<HMS+1)
        display(i);
        %size=uint8(size_arr(i)/100*(col-1));
		size=col-1;
        j=1;
        ran=zeros(1,col-1);
        while(j<size+1)
            if(HM(i,j)==1)
                p1=rand;
                if(p1<HMCR)
                    while(1) % selecting a feature from any subset in the Harmony memory
                        row_in_subset=randi([1,10]);
                        col_in_subset=randi([1,col-1]);
                        if(HM(row_in_subset,col_in_subset)==1)
                            break;
                        end
                    end
                    p2=rand;
                    if(p2<PAR)
                        while(1)
                            ep=randi([-10,10]); % generating epsilon
                            if(col_in_subset + ep>0 && col_in_subset + ep<col) % checking whether it is within bounds
                                break;
                            end
                        end
                        ran(:,col_in_subset+ep)=1; % pitch adjusted feature  
                    end
                else
                    feat_in_main=randi([1,col-1]); %randomly selecting a feature from the main feature set
                    ran(:,feat_in_main)=1;
                end    
            end
            j=j+1;
        end
        score=accuracy(ran,m1,m);
        if(acc(i,:)<score) %checking whether the new feature vector is better than the subset
            HM(i,:)=ran;
            size_arr(i,:)=int8(sum(ran(:)==1)/(col-1)*100);
            acc(i,:)=score;
            display('replaced');
            display(acc(i,:));
        end
       i=i+1;
    end
    it=it+1;
end
disp('ENDED');                            
