load carrier_demod_out.mat
load encode_in.mat

xindao=ans;

xxw=504;
m=252;
n=756;
Es=2;
r=2/3;
M=1;
Eb=Es/(r*M);
liezhong=3;
hangzhong=9;

sigma=sqrt(Eb/3);

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
demodz(1,:)=xindao(2,(quweishu+1):(quweishu+756));

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

for i=0:503
    outx3(1,(i+1))=0.001*i;
end
outx3(2,:)=decoded(1:504);

for i=0:503
    outx4(1,(i+1))=0.001*i;
end
outx4(2,:)=demodz(1:504);

save after_decode_out outx3;
save before_decode_out outx4;

derr
err


