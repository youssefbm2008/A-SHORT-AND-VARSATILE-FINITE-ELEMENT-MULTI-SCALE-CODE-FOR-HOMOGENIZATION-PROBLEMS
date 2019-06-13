
function [Kel] = matK_elemep(S1, S2, S3,Nbptmic,Nbtrimic,Coorneumic,Refneumic,Numtrimic,Reftrimic,Nbaretesmic,Numaretesmic,Refaretesmic ,epsi)
%info triangle
x1 = S1(1); y1 = S1(2);
x2 = S2(1); y2 = S2(2);
x3 = S3(1); y3 = S3(2);
D = ((x2-x1)*(y3-y1) - (y2-y1)*(x3-x1));
% D est, Aepu signe pres, deux fois l'Aepire du triAepngle
if (abs(D) <= eps) 
 error('l Aepire d un triAepngle est nulle!!!'); 
end;

%les point d'integrations (4 points) 

z1=S1/3+(S3+S2)/3;
z2=3*S1/5+(S3+S2)/5;
z3=S1/5+(S2+3*S3)/5;
z4=S1/5+(3*S2+S3)/5;

%
xbar=[z1;z2;z3;z4];
%les poids 
w=abs(D)*[-9/32;25/96;25/96;25/96];
%maintenat on va préparer les ingrédient pour calculer lamda_lin il faut
%calculer les valeurs de lamda_i aux points d'integration
norm = zeros(3, 2);
norm(1, :) = [y2-y3, x3-x2];
norm(2, :) = [y3-y1, x1-x3];
norm(3, :) = [y1-y2, x2-x1];
%grad contient les gradient des lamada_i grad(i,:) =gradeient de lamada_i 
grad=norm/D;
val=zeros(4,3);
val(:,1)=(xbar-[S3;S3;S3;S3])*grad(1,:)';
val(:,2)=(xbar-[S1;S1;S1;S1])*grad(2,:)';
val(:,3)=(xbar-[S2;S2;S2;S2])*grad(3,:)';
%val est une matrice de taille 4*3 dont la coleone num i contient les
%valeur de lamda_i aux points d'integrations
Kel = zeros(3,3);
for k=1:4
   xb=xbar(k,:);
   Coorneumic1=(Coorneumic-0.5)*epsi;
   Coorneumic1(:,1)= Coorneumic1(:,1)+xb(1);
   Coorneumic1(:,2)= Coorneumic1(:,2)+xb(2);
   [A,K,P]=micro(xb,Nbptmic,Nbtrimic,Coorneumic,Refneumic,Numtrimic,Reftrimic,Nbaretesmic,Numaretesmic,Refaretesmic );
    p=P*K;
   lin1=Coorneumic1*grad(1,:)'+val(k,1);
   lin2=Coorneumic1*grad(2,:)'+val(k,2);
   lin3=Coorneumic1*grad(3,:)'+val(k,3);
    sm1=- p*lin1;
    sm2=-p*lin2;
    sm3=-p*lin3;
    ap=p*A*p';
    L1=(ap\sm1);
    L2=(ap\sm2);
    L3=(ap\sm3);
    
    L1=p'*L1+lin1;
    L2=p'*L2+lin2;
    L3=p'*L3+lin3;
    L=[L1,L2,L3];
   



for i=1:3
  for j=1:3
	% Aep COMPLETER
    Kel(i,j) =Kel(i,j) +(w(k)/epsi^2)*(K*L(:,j))'*L(:,i);
  end; % j
end; % i
end;
   
   















%les 3 normAeples Aep l'Aeprete opposees (de lAep longueur de l'Aeprete)
% 
% 

B=(-9/32)*Aep(z1,z1)+(25/96)*(Aep(z2,z2)+Aep(z3,z3)+Aep(z4,z4));

%cAeplcul de lAep mAeptrice de rAepideur
%-------------------------------
for i=1:3
  for j=1:3
%	Aep COMPLETER
    Kel(i,j) = norm(i,:)*(B*norm(j,:)')/(abs(D));
  end; 
end; 

