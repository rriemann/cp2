clear all; clf;
L=30; N=201;
j = sqrt(-1);
T0 = 2*pi;
T = T0/10;
x_z=3;
sigma=1/sqrt(3);

for n = [10 2 1]
  [a,x,H] = ho_fou(L,N,n);

  U = expm(-j*T*H);

  psi = exp(-(x-x_z).^2/(2*sigma^2)).';
  psi = psi/norm(psi);
  gauss=psi;
  p = psi.*conj(psi);	% Wahrscheinlichkeit

  hold off;
  plot(x,p,'-');
  hold on;

  t=0;
  for i=1:5
    psi = U*psi; t=t+T;
    p = psi.*conj(psi);
    plot(x,p,'-');
    pause(1);
  end

  xlabel('x'); ylabel('p');
end

disp('PAUSE'); pause;
hold off;clf;

% Zeitentwicklung des x-Mittelwertes
for i=1:100
  xmean(i) = real((psi'.*x)*psi); % psi-kreuz x psi; sowieso reell
  tplot(i)=t;
  psi=U*psi; t=t+T;
end

plot(tplot/T0,xmean); hold; plot(tplot/T0,xmean,'x')
xlabel('t/T0'); ylabel('<x>');
