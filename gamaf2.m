function [f1,f2]=gamaf2(n1,n2,alph)
% %cubic
f1=alph*16*n1.^3;
f2=alph*16*n2.^3;



% f1=sign(n1);
% f2=sign(n2);

% f1=alph*(8*(64*n1.^7-60*n1.^5+4*n1.^3));
% f2=alph*(8*(64*n2.^7-60*n2.^5+4*n2.^3));

% %k fold
% k=6;
% theta=atan2(n2,n1)+pi/2;
% gama_theta_derivative=-k*alph*sin(k*theta);
% f1=-n2.*gama_theta_derivative;
% f2=n1.*gama_theta_derivative;

% %ellipsoidal anisotropy,
% a1=sqrt(2);
% a2=1;
% temp=sqrt(a1^2*n1.^2+a2^2*n2.^2);
% f1=a1^2*n1./temp;
% f2=a2^2*n2./temp;

% % Riemannian metric
% K=2;
% phik=[0 pi/2]; delta=[sqrt(0.01) sqrt(0.01)];

% % 
% K=3; 
% phik=[0 pi/3 2*pi/3]; delta=[sqrt(0.01) sqrt(0.01) sqrt(0.01)];
% f1=zeros(size(n1));
% f2=zeros(size(n1));
% for i=1:K
%     R_1=[cos(-phik(i)) sin(-phik(i)); -sin(-phik(i)) cos(-phik(i))];
%     R_2=[cos(phik(i)) sin(phik(i)); -sin(phik(i)) cos(phik(i))];
%     D_delta=[1 0 ;0 delta(i)^2];
%     G_k=R_1*D_delta*R_2;
%     temp=sqrt(G_k(1,1)*n1.^2+G_k(1,2)*n1.*n2+G_k(2,1)*n2.*n1+G_k(2,2)*n2.^2);
%     f1=f1+(2*G_k(1,1)*n1+G_k(2,1)*n2+G_k(1,2)*n2)./temp/2;
%     f2=f2+(2*G_k(2,2)*n2+G_k(2,1)*n1+G_k(1,2)*n1)./temp/2;
% end
