clear;

load encode_in.mat;
load sin_sampling.mat;

xxw=504;
m=252;
n=756;
Es=2;
r=2/3;
M=1;
Eb=Es/(r*M);
liezhong=3;
hangzhong=9;

s=in(2,1:504);
encode;              %LDPC±àÂë

for i=1:756
    if outx1(2,i)==0
        outx2(2,i)=1;
    else outx2(2,i)=-1;
    end
end

outx2(1,:)=outx1(1,:);

save encode_out outx2;

