load carrier_demod_out.mat;
load matrix_h.mat;

xxw=504;
m=252;
n=756;
Es=2;
r=2/3;
M=1;
Eb=Es/(r*M);
liezhong=3;
hangzhong=9;

snr=10;
sigma=sqrt(Eb/(3*10^(snr/10)));

hanglieH=size(H);
hangH=hanglieH(1);
lieH=hanglieH(2);
ncol=zeros(liezhong,lieH);
nrow=zeros(hangH,hangzhong);

lie1wei=find(H);
for a=1:lieH
    for b=1:liezhong
        ncol(b,a)=(lie1wei((a-1)*liezhong+b)-(a-1)*hangH);
    end
end

hang1wei=find(H');
for a=1:hangH
    for b=1:hangzhong
        nrow(a,b)=(hang1wei((a-1)*hangzhong+b)-(a-1)*lieH);
    end
end


xyuan=outx1(2,:);
quweishu=5;
demodz(1,:)=ryuan(2,(quweishu+1):(quweishu+756));

decode;

for i=1:756
    if demodz(1,i)>0
        demodz(1,i)=0;
    else demodz(1,i)=1;
    end
end

derr=0;
for i=1:756
    if demodz(1,i)~=xyuan(1,i)
        derr=derr+1;
    end
end


err=0;
for i=1:756
    if decoded(1,i)~=xyuan(1,i)
        err=err+1;
    end
end


derr
err

decode_out=decoded(1,1:504);
save decode_out decode_out


