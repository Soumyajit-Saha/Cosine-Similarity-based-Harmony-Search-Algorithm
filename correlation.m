function [ diff_pearson,diff_spearman,diff_kendall ] = correlation( str )
x=textread(str,'%s','bufsize',50000);
x=split(x,',');
[row,col]=size(x);
ch=x(1,col);
count=1;
for i=1:row
    if(strcmp(x(i,col),ch)~=1)
        count=count+1;
        ch=x(i,col);
    end
    y(i)=count;
end
y=y';
x=x(:,1:col-1);
x=str2double(x);d1=0;
d2=0;
d3=0;
for i=1:col-1
    t=x(:,i);
   % t=t';
   % out=py.pc.pc(t,y);
   [out1,~]=corr(t,y);
   [out2,~]=corr(t,y,'Type','Spearman');
   [out3,~]=corr(t,y,'Type','Kendall');
    if(isnan(out1)==true)           
           out1=0;
    end
    if(isnan(out2)==true)           
           out2=0;
    end
    if(isnan(out3)==true)           
           out3=0;
    end
    d1=d1+out1;
    d2=d2+out2;
    d3=d3+out3;
end
d1=d1/(col-1);
d2=d2/(col-1);
d3=d3/(col-1);
r1=0;
r2=0;
r3=0;
for i=1:col-1
    for j=1:col-1
        tx=x(:,i);
        ty=x(:,j);
        %res=py.pc.pc(tx,ty);
        [res1,~]=corr(tx,ty);
        [res2,~]=corr(tx,ty,'Type','Spearman');
        [res3,~]=corr(tx,ty,'Type','Kendall');
        if(isnan(res1)==true)           
            res1=0;
        end
        if(isnan(res2)==true)           
            res2=0;
        end
        if(isnan(res3)==true)           
            res3=0;
        end
        r1=r1+res1;
        r2=r2+res2;
        r3=r3+res3;
    end
end
r1=r1/(col-1)^2;
r2=r2/(col-1)^2;
r3=r3/(col-1)^2;
diff_pearson=d1-r1;
diff_spearman=d2-r2;
diff_kendall=d3-r3;


% d=0;
% for i=1:col-1
%     t=x(:,i);
%    % t=t';
%    % out=py.pc.pc(t,y);
%    [out,~]=corr(t,y,'Type','Spearman');
%     if(isnan(out)==true)           
%            out=0;
%     end
%     d=d+out;
% end
% d=d/(col-1);
% r=0;
% for i=1:col-1
%     for j=1:col-1
%         tx=x(:,i);
%         ty=x(:,j);
%         %res=py.pc.pc(tx,ty);
%         [res,~]=corr(tx,ty,'Type','Spearman');
%         if(isnan(res)==true)           
%             res=0;
%         end
%         r=r+res;
%     end
% end
% r=r/(col-1)^2;
% diff_spearman=d-r;
% 
% d=0;
% for i=1:col-1
%     t=x(:,i);
%    % t=t';
%    % out=py.pc.pc(t,y);
%    [out,~]=corr(t,y,'Type','Kendall');
%     if(isnan(out)==true)           
%            out=0;
%     end
%     d=d+out;
% end
% d=d/(col-1);
% r=0;
% for i=1:col-1
%     for j=1:col-1
%         tx=x(:,i);
%         ty=x(:,j);
%         %res=py.pc.pc(tx,ty);
%         [res,~]=corr(tx,ty,'Type','Kendall');
%         if(isnan(res)==true)           
%             res=0;
%         end
%         r=r+res;
%     end
% end
% r=r/(col-1)^2;
% diff_kendall=d-r;
% end
% 
