% Experimente mit der logistischen Abbildung

global r
clf;
r=[3.832, 3.9, 4];
rvals=size(r,2);
warmup=200;			% Anwendungen der Abb. vor P
points=1000;			% # x-Werte pro r-Wert
x0=0.12345;			% Startwert
x=zeros(points,rvals);		% vordefinieren wg. Geschwindigkeit
x(1,1:rvals)=x0*ones(1,rvals);	% Startwerte fuer alle r

for i=1:warmup,
  x(1,:)=logmap(x(1,:));
end
xp=zeros(1,rvals);

for i=2:points,
  xp=xp+logmapp(x(i-1,:));	% log(Ableitung) aufaddieren
  x(i,:)=logmap(x(i-1,:));	% Speichern fuer Plot
end
xp=xp/(points-1);		% Liapunov Exponent

fig = gcf;
set(fig, "visible", "off");
subplot(3,1,1),
plot(ones(points,1)*r,x,"."); hold on;
%title("logistische Abbildung");
xlabel("r"); ylabel("x");
axis([r(1)-0.01 r(rvals)+0.01 0 1]);


subplot(3,1,2),
plot(r,xp);hold on;
%title("Lyapunov Exponent");
xlabel("r"); ylabel("λ");
axis([r(1)-0.01 r(rvals)+0.01 -1 1]);
plot([r(1) r(rvals)],[0 0],":"); % Nullinie


subplot(3,1,3),
plot(r,xp);hold on;
%title("Histogramm");
xlabel("x"); ylabel("Anzahl");
axis([0,1]);
hist(x);
print("logabb.png");

% Histogramm für Aufgabe 3.1 b
clf
axis([0,1]);
ylabel("auf Anzahl der Messung gewichtetes invariantes Maß ρ(x)"); xlabel("x");
hist(x(:,end),100);
hold on;
xx = [0:1/100:0.99]';
yy = 10./(pi*sqrt(xx.*(1-xx)));
p = plot(xx,yy);
set(p,'Color','red','LineWidth',2)
print("logabb_r4.png");
