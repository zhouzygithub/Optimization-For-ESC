function f=solf(x,b)
left=-2;
right=2;
tag=1e-15;
num=1;
while(1)
    mid=(left+right)/2;
    temp=min(max((x-mid),-1),1);
    fc=sum(temp(:))-b;
    if (abs(fc)<tag) 
        break 
    end
    temp=min(max((x-left),-1),1);
    fa=sum(temp(:))-b;
    if(fa*fc<0)
        right=mid;
    end
    temp=min(max((x-right),-1),1);
    fb=sum(temp(:))-b;
    if(fb*fc<0)
        left=mid;
    end
    if(abs(left-right)<tag)
        break
    end
    num=num+1;
    if(num>1e4)
        break
    end
end
f=mid;

