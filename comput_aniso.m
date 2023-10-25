function y=comput_aniso(yt,dx,dy,A,alph,nx,ny)
%this function is used to compute the anisotropic terms
    [gx,gy]=grad(yt,dx,dy);
    gradsum=sqrt(gx.^2+gy.^2+1e-32);
    n1=gx./gradsum; n2=gy./gradsum;
    gama1=gamaf(n1,n2,alph);
    [gama2x,gama2y]=gamaf2(n1,n2,alph);
    anisoterm1=(gama1.^2-A).*gx+gama1.*gradsum.*((1-n1.^2).*gama2x-n1.*n2.*gama2y );
    anisoterm2=(gama1.^2-A).*gy+gama1.*gradsum.*((1-n2.^2).*gama2y-n1.*n2.*gama2x );
    anisoterm1=diff([anisoterm1(:,nx) anisoterm1 ]/dx,1,2);
    anisoterm2=diff([anisoterm2(ny,:);anisoterm2;]/dy,1,1);
    y=anisoterm1+anisoterm2;