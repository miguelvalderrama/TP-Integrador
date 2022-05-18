

h=10^(-7);
b=3*10^(-3);
a=0;
n=(b-a)/h;
t=linspace(a,b,n+1);
L=0.1; C=250e-6; R=2;
s1=-1/(2*R*C)-((1/(2*R*C))^2-1/(L*C))^(0.5); 
s2=-1/(2*R*C)+((1/(2*R*C))^2-1/(L*C))^(0.5); A=10;
du1=@(t,u1,u2) u2;
du2=@(t,u1,u2) -1*u2/(R*C)-u1/(L*C);
Us=A*(s1*exp(s1*t)-s2*exp(s2*t))/(s1-s2);
u1(1)=(Us(1)); u2(1)=A*(s1^2-s2^2)/(s1-s2);

for i=1:(n-1)
    u1(i+1)=u1(i)+u2(i)*h+du2(t(i),u1(i),u2(i))*h^2/2;
    u2(i+1)=u2(i)+du2(t(i),u1(i),u2(i))*h+(-1/(L*C)*u2(i)-1/(R*C)*(-u1(i)/(R*C)-u2(i)/(L*C)))*(h^2)/2;
end
P2=plot(t,u1,'k');