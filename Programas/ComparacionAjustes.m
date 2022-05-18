t=[0:(3*10^-3)/59:3*10^-3];
pvl=5;
ccms=10;
[us]=mediciones_us(t,pvl,ccms);
t=t*1000;         %cambio de escala de segundo a milisegundos 
x=t;
is=(us<=0.01);    %valores de us meonres a 0.01
us(is)=[];        %elimino valores de us que cumplen con is
x(is)=[];         %elimino valore de t correpondientes a us(is)
    
y=[us]';

n=2; %polinomio de segundo grado
V=zeros(length(x),n+1);
for i=1:n+1
    V(:,i)=x.^(n+1-i);
end
p=(V'*V)\(V'*y');            

%inicio ajuste exponencial
is=(us<=0.01);    %valores de us meonres a 0.01
us(is)=[];        %elimino valores de us que cumplen con is
x(is)=[];         %elimino valore de t correpondientes a us(is)


y=(us)';
ylog=log(y);
n=length(x);           %nro de datos
m=2;                   %nro de coeficientes 
H=zeros(n,m);
for c=1:m
H(:,c)=x.^(c-1);
end

Ht=H';
a=inv(Ht*H)*(Ht*(ylog'));
T=t(1):0.01:t(numel(t));
b=e.^a;
f=b(1).*(b(2).^T);
hold on
P2=plot(x,y,'k*',T,f,'b');
g=@(x) polyval(p,x);
P1=fplot(g,[x(1),x(end)],'r')
xlabel('x')
ylabel('y')
grid on
hold off
