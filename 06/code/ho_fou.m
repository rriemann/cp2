%  Erzeugung Diskretisierung und 
%  Hamilton Operator fuer QM Harmonischen Oszillator
%  mit Fourier Ableitung
%  Aufruf [a,x,H] = ho_fou(L,N)
%
function [a,x,p,H] = ho_fou(L,N)

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
H = zeros(N,N);
for i=1:N,
  H      = H + imp(i)^2*cos(imp(i)*A);
  for j=abs(imp),
    p(i,:) += 2*sqrt(-1)/N*j*sin(j*(x(i).-x));
  end
end      % kein i*sin wg. p<->-p Symm. 
H = H*(0.5/N);                                  % (-1/2) Laplace

%  Potential, Oszillator Teil des Hamilton:
H=H+0.5*diag(x.^2);

disp(' H.O. Hamilton mit Fourier-diskretisiertem Laplace Operator: ')
fprintf(' Raumintervall [%g , %g] mit %i Punkten \n',[-L/2 L/2 N]);
