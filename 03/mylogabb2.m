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

subplot(3,1,1),
plot(ones(points,1)*r,x,"."); hold on;
title("logistische Abbildung");
xlabel("r"); ylabel("x");
axis([r(1)-0.01 r(rvals)+0.01 0 1]);


subplot(3,1,2),
plot(r,xp);hold on;
title("Lyapunov Exponent");
xlabel("r"); ylabel("lambda");
axis([r(1)-0.01 r(rvals)+0.01 -1 1]);
plot([r(1) r(rvals)],[0 0],":"); % Nullinie


subplot(3,1,3),
plot(r,xp);hold on;
title("Histogramm");
xlabel("x"); ylabel("Anzahl");
axis([0,1]);
hist(x);			% gleich fuer alle r-werte gleichzeitig
				% mit einem 2. argument koennte man Nbins festlegen