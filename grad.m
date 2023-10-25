function [grad_x,grad_y]=grad(x,dx,dy)
grad_x=diff([x x(:,1)]/dx,1,2);
grad_y=diff([x;x(1,:)]/dy,1,1);
