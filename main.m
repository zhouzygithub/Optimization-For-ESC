%main
clc
clear
format long
eps=2e-2;
NNN=256;
nx=NNN;
ny=NNN;
Lx=1;
Ly=1;
L=Lx;
alph=0.2;
%splitting parameter
A=10;
B=2;

dx=Lx/nx; dy=Ly/ny;
xx=linspace(dx/2,Lx-dx/2,nx);
yy=linspace(dy/2,Ly-dy/2,ny);
[X,Y]=meshgrid(xx,yy);

%%%%%   some initial condition \phi
initial=0.3;
phi=-tanh((sqrt((X-Lx/2).^2+(Y-Ly/2).^2)-initial)/(sqrt(2)*2e-2));

% phi=-tanh((sqrt((X-0.4*Lx).^2+(Y-0.6*Ly).^2)-Lx/4)/eps)-tanh((sqrt((X-0.8*Lx).^2+(Y-0.2*Ly).^2)-0.16)/eps)+1;

% phi=-0.5+0.001*rand(size(phi));

%%%%%   construct fourier matrix
[mX,mY]=meshgrid(1:nx,1:ny);
MM=((4*sin(pi*(mX-1)/(nx)).^2)+(4*sin(pi*(mY-1)/(ny)).^2))/dx/dy; 

%%%%%%% some test parameters
num=1;
m0=sum(phi(:));
e0=1e18;
energy1=zeros(1,1e8);
energy2=zeros(1,1e8);
% massx=zeros(1,1e8);
% massy=zeros(1,1e8);
% massz=zeros(1,1e8);
max_of_z=zeros(1,1e8);
min_of_z=zeros(1,1e8);
optimal=zeros(1,1e8);
energy_ori=zeros(1,1e8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%   iteration prepare
tau=1;
yt=phi;
yt0=yt;
xt=ifft2(fft2(yt).*(1+B*tau+eps^2*A*MM*tau));
xt=real(xt);
% mx=sum(xt(:)); my=sum(yt(:)); mz=sum(phi(:));
while(1)
    %fft solve subproblem 
    yt=ifft2(fft2(xt)./(1+B*tau+eps^2*A*MM*tau));
    yt=real(yt);
    %%%%%   compute anisotropic terms
    anisoterm=comput_aniso(yt,dx,dy,A,alph,nx,ny);
%     Ht=(yt.^3-1*yt-B*yt)-eps^2*(anisoterm);
    Ht=(yt.^3-1*yt-B*yt).*(abs(yt)<=1)+(2*yt-2-B*yt).*(yt>1)+(2*yt+2-B*yt).*(yt<-1)-eps^2*(anisoterm);
    temp=2*yt-xt-tau*Ht;
    %projection
    mu=solf(temp,m0);
    zt=min(max((temp-mu),-1),1); 
    %laststep
    xt=xt+(zt-yt);
    
%     draw picture during the iterations
%     drawnow;
%     contour(zt,[0 0]);
%     axis equal
    
% %     some test data    
%     max_of_z(num)=max(zt(:));
%     min_of_z(num)=min(zt(:));    
%         massy(num)=sum(yt(:));
%         massz(num)=sum(zt(:));
%         massx(num)=sum(xt(:));
%         energy1(num)=e;
%         optimal(num)=norm(zt-yt)*dx*dx/tau;
%         energy_ori(num)=e_ori;
  
%     %%% compute energy
%     [gx,gy]=grad(yt,dx,dy);
%     gradsum=sqrt(gx.^2+gy.^2)+1e-32;
%     n1=gx./gradsum; n2=gy./gradsum;
%     f=(yt.^2-1).^2/4.*(abs(yt)<=1)+(abs(yt)-1).^2.*(abs(yt)>1)+eps^2/2*gamaf(n1,n2,alph).^2.*(gx.^2+gy.^2);
%     f=sum(f(:));
%     anisoterm=comput_aniso(yt,dx,dy,A,alph,nx,ny);
%     Ht=(yt.^3-1*yt-B*yt).*(abs(yt)<=1)+(2*yt-2-B*yt).*(yt>1)+(2*yt+2-B*yt).*(yt<-1)-eps^2*(anisoterm);
%     energy2(num)=f;
%     e=f+(norm(2*yt-zt-xt-tau*Ht,'fro')^2-norm(xt-yt+tau*Ht,'fro')^2-norm(yt-zt,'fro')^2*2)/tau/2;
%     e_ori=f;
% 
%      %%% compute original energy 
%      [gx,gy]=grad(yt,dx,dy);
%     gradsum=sqrt(gx.^2+gy.^2)+1e-32;
%     n1=gx./gradsum; n2=gy./gradsum;
%     f=(yt.^2-1).^2/4+eps^2/2*((gamaf(n1,n2,alph)).^2).*(gx.^2+gy.^2+1e-32);
%     f=sum(f(:));
%     e=f;

    
    if norm(yt0-yt)*dx*dx>1/num*1e-0 || norm(yt)*dx*dx>10
        tau=max(tau*0.5,1e-8);
        if tau<1e-8
            break;
        end 
    end
  
% stop condition: fisrt order optimal condition<1e-8
        norm(zt-yt)*dx*dx/tau
        if  norm(zt-yt)*dx*dx/tau<1e-8 &&num>1
            break
        end
%         e0=e;
        yt0=yt;
        num=num+1;
end
%%%%%   figure
phi=reshape(zt,[ny,nx]);
v = [0,0];
[C1,hh]=contour(X,Y,phi,v);
axis equal
hh.LineColor='b';

phi=reshape(phi,[ny,nx]);
pcolor(X,Y,phi);
shading interp; 
colorbar; colormap(jet);
xlabel('x','fontsize',15);ylabel('y','fontsize',15);
axis equal
