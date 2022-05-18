load 'audio.mat'
L=0.1; C=250e-6; R=2;
j=1/h;
puntos=sig;

n=length(puntos);
b=h*(n);
x=0:h:b;
diff=zeros(1,n);
for i=1:n
    if i~=n
        diff(i)=(puntos(i+1)-puntos(i))/h;
    else
        diff(i)=(puntos(i)-puntos(i-1))/h;
    end
end
%%RK4
t=x;
du1=@(t,diff,il,u2) u2;
du2=@(t,diff,il,u2) diff/L-1*u2/(R*C)-il/(L*C);
i2=zeros(1,n); i2(1)=0; il=zeros(1,n); il(1)=0;

for i=1:n-1
    k11=h*du1(t(i),0,il(i),i2(i));
    k12=h*du2(t(i),diff(i),il(i),i2(i));
    
    k21=h*du1(t(i)+h*0.5,0,il(i)+k11*0.5,i2(i)+k12*0.5);
    k22=h*du2(t(i)+h*0.5,diff(i),il(i)+k11*0.5,i2(i)+k12*0.5);
    
    k31=h*du1(t(i)+h*0.5,0,il(i)+k21*0.5,i2(i)+k22*0.5);
    k32=h*du2(t(i)+h*0.5,diff(i),il(i)+k21*0.5,i2(i)+k22*0.5);
    
    k41=h*du1(t(i)+h,0,il(i)+k31,i2(i)+k32);
    k42=h*du2(t(i)+h,diff(i),il(i)+k31,i2(i)+k32);
    
    il(i+1)=il(i)+(k11+2*k21+2*k31+k41)*(1/6);
    i2(i+1)=i2(i)+(k12+2*k22+2*k32+k42)*(1/6);
end
u3=i2*L;
plot(u3)
sound(u3,j)