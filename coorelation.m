function [ out ] = coorelation( str )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    recsv=textread(str,'%s','bufsize',50000);
	recsv=split(recsv,',');
	[row1,col1]=size(recsv);
    re=recsv(:,col1);
	recsv=recsv(:,1:col1-1);
	re=re';
	recsv=str2double(recsv);
    ch=re(1,1);
    count=1;
    for i=1:row1
        if(strcmp(re(1,i),ch)~=1)
            count=count+1;
            ch=re(1,i);
        end
        temp1(i)=count;
    end
    k=1;
    for i=1:row1
        for j=1:col1-1
            x(k)=recsv(i,j);
            y(k)=temp1(i);
            k=k+1;
        end
    end
    out=py.spear.spear(x,y);
end

