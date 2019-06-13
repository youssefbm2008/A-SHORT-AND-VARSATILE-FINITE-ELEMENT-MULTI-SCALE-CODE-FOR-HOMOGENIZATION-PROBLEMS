 


% lecture du maillage et affichage
% ---------------------------------
nom_maillage = 'geomCarre.msh';
[Nbpt,Nbtri,Coorneu,Refneu,Numtri,Reftri,Nbaretes,Numaretes,Refaretes]=lecture_msh(nom_maillage);
 nom_maillage = 'cellule.msh';
 [Nbptmic,Nbtrimic,Coorneumic,Refneumic,Numtrimic,Reftrimic,Nbaretesmic,Numaretesmic,Refaretesmic ]=lecture_msh(nom_maillage);
 Nbtri

% ----------------------
% calcul des matrices EF
% ----------------------

% declarations
% ------------
%KK = sparse(Nbpt,Nbpt); % matrice de rigidite
KKep = sparse(Nbpt,Nbpt); % matrice de rigidite
MM = sparse(Nbpt,Nbpt); % matrice de rigidite
LL = sparse(Nbpt,1);     % vecteur second membre
FF = sparse(Nbpt,1);  
global epsi;
 epsi=1;
% boucle sur les triangles
for l=1:Nbtri
  S1=Coorneu(Numtri(l,1),:);
  l
  S2=Coorneu(Numtri(l,2),:);
  S3=Coorneu(Numtri(l,3),:);
   %Kel=matK_elem(S1, S2, S3);  
  % Kel1=matK_elem1(S1, S2, S3);
    Kelep=matK_elemep(S1, S2, S3,Nbptmic,Nbtrimic,Coorneumic,Refneumic,Numtrimic,Reftrimic,Nbaretesmic,Numaretesmic,Refaretesmic ,1e-5);  
   Mel=matM_elem(S1, S2, S3);
    for i=1:3
      I= Numtri(l,i) ;
        for j=1:3
         J=Numtri(l,j) ;     
        MM(I,J)= MM(I,J)+Mel(i,j);
        KKep(I,J)= KKep(I,J)+Kelep(i,j);
       % KK(I,J)= KK(I,J)+Kel(i,j);
        end;
    end 
end 
%second membre
for i=1:Nbpt
  FF(i)=f(Coorneu(i,1),Coorneu(i,2));
end
LL = MM*FF;


% Projection sur l espace V_0
% ———————————————————
% matrice de projection 
P = P1(Refneu,Nbpt);
BB0=P*KKep*P';
LL0 =P*LL;

% inversion
% ----------

UUe=BB0\LL0;
% Expression de la solution dans toute la base
% ———————
UUep= P'*UUe;
% visualisation
% -------------
affiche(UUep, Numtri, Coorneu, sprintf('Direchlet approchée u eps- %s', nom_maillage));

