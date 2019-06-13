function [PP,N0] = P1(Refneu,Nbpt);

N0 = 0;
for i =1:Nbpt
    if (Refneu(i) == 0)
        N0 = N0+1;
    end
end %i

PP = zeros(N0,Nbpt); 
s = 1;
for j=1:Nbpt
    if (Refneu(j) == 0)
        PP(s,j) =1;
        s = s+1;
    end
end