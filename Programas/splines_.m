t=[0:(3*10^-3)/59:3*10^-3];
pvl=5;
ccms=10;
[us]=mediciones_us(t,pvl,ccms);


X = t;
Y = us;

fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)
p0 = plot(X,Y,'b*','MarkerSize',10);
xlabel('t(sg)')
ylabel('Us')
grid on
hold on

%Spline Lineal
for idx = 1:length(X)-1
   m = (Y(idx+1)-Y(idx) )/(X(idx+1)-X(idx));
   xspline = linspace(X(idx),X(idx+1),10);
   yspline = m*(xspline-X(idx)) + Y(idx);
   p1 = plot(xspline,yspline,'g-','LineWidth',2);
end

%Spline Cuadratico

N = length(X);
n = N-1;

%%%%Create H0 = [2*(n-1)  x 3*n]
H0 = zeros(2*n-2,3*n);
K0 = zeros(2*n-2,1);
for idx = 1:(n-1)
    col = idx;
    row = 2*(idx-1)+1;
    H0(row,col) = X(idx+1)^2;
    H0(row+1,col+1) = X(idx+1)^2;
    H0(row,n+col) = X(idx+1);
    H0(row+1,n+col+1) = X(idx+1);
    H0(row,2*n+col) = 1;
    H0(row+1,2*n+col+1) = 1;
    K0(row) = Y(idx+1);
    K0(row+1) = Y(idx+1);
end


H1 = zeros(n-1,3*n);
for idx = 1:n-1
    H1(idx,idx) = 2*X(idx+1);
    H1(idx,idx+1) = -2*X(idx+1);
    H1(idx,n+idx) = 1;
    H1(idx,n+idx+1) = -1;
end

HE = zeros(2,3*n);
HE(1,1) = X(1)^2;
HE(1,n+1) = X(1);
HE(1,2*n+1) = 1;
HE(2,n) = X(end)^2;
HE(2,2*n) = X(end);
HE(2,end) = 1;


H = [H0;H1;HE];
[r,c] = size(H);


K = zeros(r,1);
K(1:(2*(n-1))) = K0;
K(end-1) = Y(1);
K(end) = Y(end);


H = H(:,2:end);

coeffs = inv(H)*K;


A = [0;coeffs(1:n-1)];
B = coeffs(n:2*n-1);
C = coeffs(2*n:end);

%Resultados
for idx = 1:n
    xspline = linspace(X(idx),X(idx+1),10);
    yspline = A(idx)*xspline.^2 + B(idx)*xspline + C(idx);
    p2 = plot(xspline,yspline,'r-','LineWidth',2);
end

% Spline Cubico
k1=0:0.00001:0.003;
yspline=spline(t,us,k1);
p3=plot(k1,yspline,'b-');

title('Interpolacion M?todo Spline');
legend([p0 p1 p2 p3],'Puntos datos','Spline Lineal','Spline Cuadratico','Spline Cubico')