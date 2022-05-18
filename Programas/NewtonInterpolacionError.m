clear all
clc

t=[0:(3*10^-3)/59:3*10^-3];
pvl=5;
ccms=10;
[us]=mediciones_us(t,pvl,ccms);

x=t ;y=us';


xmin=min(x); xmax=max(x);
xx=linspace(xmin,xmax);
n=length(x);% Longitud del vector x = numero de nodos
M=zeros(n,n+1);
M(:,1)=x;M(:,2)=y;

for i=2:n
   
   
    for j=i:n
M(j,i+1)= (M(j,i)-M(j-1,i))/(M(j,1)- M(j-i+1,1));

    end
    
end

% Coeficientes obtenidos por diferencias divididas hacia adelante
for i=1:n
cf(i)=M(i,i+1);
end
Newton=cf(1);
s=1;
for i=1:n-1
    
 s=conv(s,[1 -x(i)]);  
 
 N=polyval(s,xx);
 Newton=Newton+cf(i+1)*N;

end
fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)
p0 = plot(x,y,'r*');
xlabel('t(sg)')
ylabel('Us(V)')
grid on
hold on
p1=plot(xx,Newton,'-b'),grid on 
title('Interpolacion Método Newton')
legend([p0 p1],'Puntos datos','Interpolacion Merodo de Newton')
## figure(2)
## C=polyfit(x,y,4);
## f=polyval(C,xx);
## plot(xx,f,'-.r',x,y,'o','MarkerEdgeColor','k','MarkerFaceColor','y'),grid on %,axis([-1 7 -50 300])