p=textread('C:/talip-csv-10000+15000/transition_global_local_concentric_topological_unit_data_64_normalized_45_rotation.csv','%s');
p=split(p,',');
[row,col]=size(p);
m1=p(2:row,col);
m1=m1';
p=p(2:row,1:col-1);
p=str2double(p);
c=1;
for j=1:col-1
    max_value=max(p(:,j));
    min_value=min(p(:,j));
    if((max_value-min_value)~=0)
        m(:,c)=p(:,j);
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
        