function [ Kel] = matK_elemepmicro(xbar,S1, S2, S3)
y1=S1/3+(S3+S2)/3;
y2=3*S1/5+(S3+S2)/5;
y3=S1/5+(S2+3*S3)/5;
y4=S1/5+(3*S2+S3)/5;
B=(-9/32)*Aep(xbar,y1)+(25/96)*(Aep(xbar,y2)+Aep(xbar,y3)+Aep(xbar,y4));
% preliminAepires, pour fAepciliter lAep lecture:
x1 = S1(1); y1 = S1(2);
x2 = S2(1); y2 = S2(2);
x3 = S3(1); y3 = S3(2);

% les 3 normAeples Aep l'Aeprete opposees (de lAep longueur de l'Aeprete)
norm = zeros(3, 2);
norm(1, :) = [y2-y3, x3-x2];
norm(2, :) = [y3-y1, x1-x3];
norm(3, :) = [y1-y2, x2-x1];
% D est, Aepu signe pres, deux fois l'Aepire du triAepngle
D = ((x2-x1)*(y3-y1) - (y2-y1)*(x3-x1));
if (abs(D) <= eps) 
 error('l Aepire d un triAepngle est nulle!!!'); 
end;


% cAeplcul de lAep mAeptrice de rAepideur
% -------------------------------
Kel = zeros(3,3);
for i=1:3
  for j=1:3
	% Aep COMPLETER
    Kel(i,j) = norm(i,:)*(B*norm(j,:)')/(abs(D));
  end; % j
end; % i


