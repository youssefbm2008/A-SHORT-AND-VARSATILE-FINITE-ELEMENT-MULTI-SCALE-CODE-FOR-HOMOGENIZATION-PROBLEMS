function PP_per = P_per(Nbpt,Refneu,Coorneu);


%indice du 3eme coté
k=find(Refneu==3);


n1 = size(k,1);

PP_per = zeros(Nbpt-3-(2*n1),Nbpt);
for d=1:4
    PP_per(1,d) = 1;
end %d
s = 2;

for j=5:Nbpt
    if (Refneu(j) == 0)
        PP_per(s,j) =1;
        s = s+1;
    end
    if (Refneu(j) == 1)
        Ref = 3;
        index = 1;
        PP_per(s,j) = 1;
        j1 = ident(j,Ref,Refneu,Coorneu,Nbpt,index);
        PP_per(s,j1) = 1;
        s = s+1;
    end
    if (Refneu(j) == 2)
        Ref = 4;
        index = 2;
        PP_per(s,j) = 1;
        j2 = ident(j,Ref,Refneu,Coorneu,Nbpt,index);
         PP_per(s,j2) = 1;
         s = s+1;
    end
end