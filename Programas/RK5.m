clc;
clear all;
close all;
h=10^(-7);
b=3*10^(-3);
a=0;
n=(b-a)/h;
t=linspace(a,b,n+1);
L=0.1; C=250e-6; R=2; f=300; w=2*pi*f;
du1=@(t,u1,u2) u2;
du2=@(t,u1,u2) -1*u2/(R*C)-u1/(L*C)-((w^2)*sin(w*t));
s1=-1/(2*R*C)-((1/(2*R*C))^2-1/(L*C))^(0.5); 
s2=-1/(2*R*C)+((1/(2*R*C))^2-1/(L*C))^(0.5); A=0;
Us=(A*(s1*exp(s1*t)-s2*exp(s2*t))/(s1-s2)) +(w^4 *sin(t *w))/(w^4 + 3920000 *w^2 + 1600000000) - (40000* w^2 *sin(t* w))/(w^4 + 3920000 *w^2 + 1600000000) + (2000 *w^3 *cos(t* w))/(w^4 + 3920000* w^2 + 1600000000);
u1(1)=(Us(1)); u2(1)=(A*(s1^2-s2^2)/(s1-s2))+(w^5 *cos(0))/(w^4 + 3920000 *w^2 + 1600000000) - (40000* w^3 *cos(0))/(w^4 + 3920000 *w^2 + 1600000000) - (2000 *w^4 *sin(0))/(w^4 + 3920000* w^2 + 1600000000);;

for i=1:n-1
    k11=h*du1(t(i),u1(i),u2(i));
    k12=h*du2(t(i),u1(i),u2(i));
    
    k21=h*du1(t(i)+h*0.5,u1(i)+k11*0.5,u2(i)+k12*0.5);
    k22=h*du2(t(i)+h*0.5,u1(i)+k11*0.5,u2(i)+k12*0.5);
    
    k31=h*du1(t(i)+h*0.5,u1(i)+k21*0.5,u2(i)+k22*0.5);
    k32=h*du2(t(i)+h*0.5,u1(i)+k21*0.5,u2(i)+k22*0.5);
    
    k41=h*du1(t(i)+h,u1(i)+k31,u2(i)+k32);
    k42=h*du2(t(i)+h,u1(i)+k31,u2(i)+k32);
    
    u1(i+1)=u1(i)+(k11+2*k21+2*k31+k41)*(1/6);
    u2(i+1)=u2(i)+(k12+2*k22+2*k32+k42)*(1/6);
end

plot(t,u1,'r');
title('Entrada Sinusoidal');