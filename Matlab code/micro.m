function [AA,KKep,P]=micro(xbar,Nbpt,Nbtri,Coorneu,Refneu,Numtri,Reftri,Nbaretes,Numaretes,Refaretes)
%nom_maillage = 'cellule.msh';
%[Nbpt,Nbtri,Coorneu,Refneu,Numtri,Reftri,Nbaretes,Numaretes,Refaretes]=lecture_msh(nom_maillage);

% ----------------------
% calcul des matrices EF
% ----------------------

% declarations
KK = sparse(Nbpt,Nbpt); % matrice de rigidite
KKep = sparse(Nbpt,Nbpt); % matrice de rigidite
MM = sparse(Nbpt,Nbpt); % matrice de rigidite
LL = sparse(Nbpt,1);     % vecteur second membre
FF = sparse(Nbpt,1);  
% boucle sur les triangles
for l=1:Nbtri
  S1=Coorneu(Numtri(l,1),:);
  S2=Coorneu(Numtri(l,2),:);
  S3=Coorneu(Numtri(l,3),:);
%    Kel=matK_elem(S1, S2, S3);  
   Kelep=matK_elemepmicro(xbar,S1, S2, S3);      
   Mel=matM_elem(S1, S2, S3);
    for i=1:3
      I= Numtri(l,i) ;
        for j=1:3
         J=Numtri(l,j) ;     
        MM(I,J)= MM(I,J)+Mel(i,j);
       KKep(I,J)= KKep(I,J)+Kelep(i,j);
%         KK(I,J)= KK(I,J)+Kel(i,j);
        end;
    end 
end 
%second membre
%LLx = -KKep*Coorneu(:,1);
% Projection sur l espace V_p
% ———————————————————
% matrice de projection 
P = P_per(Nbpt,Refneu,Coorneu);
%spy(P)
mu=0.00001;
AA = mu*MM+KKep;
%AAp =P*AA*P';
%LLpx = P*LLx;
% inversion
% ----------
%UUpx = AAp\LLpx;
% Expression de la solution dans toute la base
% ———————
%UUx = P'*UUpx;

% visualisation
% -------------
%affiche(UUx, Numtri, Coorneu, sprintf('W1-approchée - %s', nom_maillage));

end
