function PN=mseq(a)
if a==1
x2=1;x1=0;x0=0;
m=90;
for i=1:m
    PN(i)=x0;
    y2=xor(x2,x0);
    x0=x1;x1=x2;x2=y2;
end
end