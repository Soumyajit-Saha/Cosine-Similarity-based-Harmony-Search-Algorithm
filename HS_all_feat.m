HM=X;
HMCR=0.7;
PAR=0.3;
it=1;
HMS=15;
acc=zeros(15,1);
for hi=1:15
    %acc(hi,:)=rand;
    acc(hi,:)=feasibility_check(HM(hi,:),m1,m);
    display(acc(hi,:));
end

while(it<20)
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
%                     while(1) % selecting a feature from any subset in the Harmony memory
%                         %row_in_subset=randi([1,10]);
%                         col_in_subset=randi([1,col-1]);
%                         if(HM(i,col_in_subset)==1)
%                             break;
%                         end
%                     end
                    col_in_subset=j;
                    p2=rand;
                    if(p2<PAR)
                        while(1)
                            ep=rand; % generating epsilon
                            t=1;
                            flag=0;
                            while(t<11)
                                rand_feat=randi([1,col-1]);
                                if(ep>sim_mat(j,rand_feat))
                                    flag=1;
                                    break;
                                end
                                t=t+1;
                            end 
                            if(flag==1)
                                break;
                            end
                        end
                        ran(:,rand_feat)=1;
                    else
                        ran(:,col_in_subset)=1;
                    end
                else
                    feat_in_main=randi([1,col-1]); %randomly selecting a feature from the main feature set
                    ran(:,feat_in_main)=1;
                end    
            end
            j=j+1;
        end  
            score=feasibility_check(ran,m1,m,row,col);
            %score=rand;
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
