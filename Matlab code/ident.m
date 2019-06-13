function jj = ident(j,Ref,Refneu,Coorneu,Nbpt,index)

% z=round(10^6*Coorneu(j,index))/(10^6);
z=Coorneu(j,index);
    for i = 5:Nbpt
        %d=round(10^6*Coorneu(i,index))/(10^6);
        d=Coorneu(i,index);
        if ((abs(z - d )< 0.01 ) && (Refneu(i) == Ref))
            jj = i;
        end
    end
   