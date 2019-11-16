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
    [min_set,pos]=min(acc);
    i=1;
    while(i<HMS+1)
        display(i);
        p1=rand;
        if(p1<HMCR)
            size=uint8(size_arr(i)/100*(col-1));
            j=1;
            ran=zeros(1,col-1);
            while(j<size+1)
                att_no=randi(col-1);
                if(ran(att_no)==1)
                    continue;
                else
                    ran(att_no)=1;
                    j=j+1;
                end
            end
            if(ran==HM(i,:))
              continue;            
            end
            p2=rand;
            if(p2<PAR)
                ran_temp=zeros(1,col-1);
                while(1)
                    for att=1:389
                        if(ran(att)==1)
                            ep=randi([-10,10]);
                            if(att+ep<1 || att+ep>389)
                                continue;
                            end
                            ran_temp(att+ep)=1;
                        end
                    end
                    if(sum(ran_temp(:)==1)>116) %should not be less than 30 percent of 389
                        break;
                    end
                end
                ran=ran_temp;
            end
        else
            perc=randi([30,80]);
            size=uint8(perc/100*(col-1));
            j=1;
            ran=zeros(1,col-1);
            while(j<size+1)
%                 att_no=randi(col-1);
%                 if(ran(att_no)==1)
%                     continue;
%                 else
%                     ran(att_no)=1;
%                     j=j+1;
%                 end
                ran(:,j)=HM(int8(rand*10),j);
                perc=int8(sum(ran(:)==1)/(col-1)*100);
            end
            
        end
        score=accuracy(ran,m1,m);
        if(acc(pos,:)<score)
            HM(pos,:)=ran;
            size_arr(pos,:)=perc;
            acc(pos,:)=score;
            display('replaced');
            display(acc(pos,:));
        end
        i=i+1;
    end
    it=it+1;
end
disp('ENDED');                            
