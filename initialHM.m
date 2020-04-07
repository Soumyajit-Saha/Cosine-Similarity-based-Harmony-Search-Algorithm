%m=textread('C:/talip-csv-10000+15000/transition_global_local_concentric_topological_unit_data_64_normalized_45_rotation.csv','%s');
%m=split(m,',');
%[row,col]=size(m);
%m1=m(2:row,col);
%m1=m1';
%m=m(2:row,1:col-1);
%m=str2double(m);
X=zeros(10,col-1);
size_arr=zeros(10,1);
it=1;
while(it<11)
    perc=randi([30,65]);
    display(it);
    size=uint8(perc/100*(col-1));
    i=1;
    track=zeros(1,col-1);
    while(i<size+1)
        att_no=randi(col-1);
        if(track(att_no)==1)
            continue;
        else
            track(att_no)=1;
            i=i+1;
        end
    end
%     display('END OF WHILE I');
    f=0;
    for j=1:it-1
        if(track==X(j,:))
            f=1;
            break;
        end
    end
    if(f==1)
        continue;
    else
        X(it,:)=track;
        size_arr(it)=perc;
        %display(it);
        it=it+1;
    end
end
        
    
