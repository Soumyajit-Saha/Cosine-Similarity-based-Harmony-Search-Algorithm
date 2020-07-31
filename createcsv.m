for k=1:15
    f1=fopen(sprintf('C:/project/FER/test_journal/ulbp_rafd_48/%d.csv',k),'w');
    for i1=1:row-1
        for c=1:col-1
        if(HM(k,c)==1)
           fprintf(f1,'%f,',X_train(i1,c));
        end
        end
           %fprintf(f1,'%f\n',temp(i1,cx));
           fprintf(f1,'%s\n',Y_train{:,i1});
    end
    fclose(f1);
end