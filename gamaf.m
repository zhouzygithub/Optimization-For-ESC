function f=gamaf(n1,n2,alph)
% % cubic
f=1+alph*(4*(n1.^4+n2.^4)-3);
% f=1+alph*(8*(8*(n1.^8+n2.^8)-10*(n1.^6+n2.^6)+(n1.^4+n2.^4))+9);



% f=abs(n1)+abs(n2);

% % k fold
% k=6;
% theta=atan2(n2,n1)+pi/2;
% f=1+alph*cos(k*theta);


% % ellipsoidal anisotropy,
% a1=sqrt(2);
% a2=1;
% f=sqrt(a1^2*n1.^2+a2^2*n2.^2);

% % % Riemannian metric
% 
% K=2;
% phik=[0 pi/2]; delta=[sqrt(0.01) sqrt(0.01)];
% 
% K=3; 
% 
% phik=[0 pi/3 2*pi/3]; delta=[sqrt(0.01) sqrt(0.01) sqrt(0.01)];
% 
% f=0;
% % 
% for i=1:K
%     R_1=[cos(-phik(i)) sin(-phik(i)); -sin(-phik(i)) cos(-phik(i))];
%     R_2=[cos(phik(i)) sin(phik(i)); -sin(phik(i)) cos(phik(i))];
%     D_delta=[1 0 ;0 delta(i)^2];
%     G_k=R_1*D_delta*R_2;
%     f=f+sqrt(G_k(1,1)*n1.^2+G_k(1,2)*n1.*n2+G_k(2,1)*n2.*n1+G_k(2,2)*n2.^2);
% end