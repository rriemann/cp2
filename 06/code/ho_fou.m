function [a,x,p] = ho_fou(L,N)

if ~mod(N,2), error('ho_fou.m: N muss ungerade sein');end
M=(N-1)/2;
%  Raum:
a = L/N;               % Diskretisierungslaenge
x=       a*(-M:M);     % x-Werte
imp=(2*pi/L)*(-M:M);     % Impulse
p = zeros(N);

%  kinetischer Teil des Hamilton:
A = zeros(N,N);
for i=1:N, A(i,:) = x(i) - x; end               % Matrix (x_i - x_j)
for i=1:N,
  for j=imp(N/2+0.5:N),
    p(i,:) += 2*sqrt(-1)/N*j*sin(j*(x(i).-x));
  end
end      % kein i*sin wg. p<->-p Symm. 

%  Potential, Oszillator Teil des Hamilton:
x = diag(x);

fprintf(' Raumintervall [%g , %g] mit %i Punkten \n',[-L/2 L/2 N]);
