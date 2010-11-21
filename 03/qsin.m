global q
clf;
q=[0.01:0.01:1];
qvals=size(q,2);
warmup=200;			% Anwendungen der Abb. vor P
points=1000;			% # x-Werte pro q-Wert
x0=0.12345;			% Startwert
x=zeros(points,qvals);		% vordefinieren wg. Geschwindigkeit
x(1,1:qvals)=x0*ones(1,qvals);	% Startwerte fuer alle q

for with_uncert = 0:1,
  for i=1:warmup,
    x(1,:)=qsinfct(x(1,:),with_uncert);
  end
  xp=zeros(1,qvals);

  for i=2:points,
    xp=xp+qsinabl(x(i-1,:));			% log(Ableitung) aufaddieren
    x(i,:)=qsinfct(x(i-1,:),with_uncert);	% Speichern fuer Plot
  end
  xp=xp/(points-1);				% Liapunov Exponent

%  figure(with_uncert+1);
  subplot(3,1,1),
  plot(ones(points,1)*q,x,".");% hold on;
  title("q*sin(πx)");
  xlabel("q"); ylabel("x");
  axis([q(1)-0.01 q(qvals)+0.01 0 1]);


  subplot(3,1,2),
  plot(q,xp);hold on;
  title("Lyapunov Exponent");
  xlabel("q"); ylabel("λ");
  axis([q(1)-0.01 q(qvals)+0.01 -1 1]);
  plot([q(1) q(qvals)],[0 0],":"); % Nullinie
  hold off;


  subplot(3,1,3),
  plot(q,xp);%hold on;
  title("Histogramm");
  xlabel("x"); ylabel("Anzahl");
  axis([0,1]);
  hist(x);		% gleich fuer alle q-werte gleichzeitig
			% mit einem 2. argument koennte man Nbins festlegen
  print(sprintf("qsin%i.png", with_uncert));
%  print("qsin.pdf");
%  hold off;
end