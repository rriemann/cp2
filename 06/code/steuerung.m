%  aufgabe 6.1a)
[a,x,p] = ho_fou(10,11);


%  6.2a)
C = i*(p*x-x*p);

figure(1);
fig = gcf;
set(fig, "visible", "off");

mesh(real(x),real(C));
print("../tmp/mesh_c_over_x.pdf");
mesh(real(C));
print("../tmp/mesh_c.pdf");


%  6.1d
L = 20;
N = 101;                % oder 201 und 1001
[a,x,p] = ho_fou(L,N);
C = i*(p*x-x*p);
x = sum(x);		% zeilenvektor
Diff = zeros(L);
sigma = 0.5;		% beliebig

for z1 = 1:L+1,
  psi1 = exp(-1/2*(x-(z1-L/2-1)).^2/sigma^2);
  psi1 = psi1/sqrt(psi1*psi1');
  for z2 = 1:L+1,
    psi2 = exp(-1/2*(x-(z2-L/2-1)).^2/sigma^2);
    psi2 = psi2/sqrt(psi2*psi2');
    Diff(z1,z2) = psi1*C*psi2'-psi1*psi2';
  end
end

%  mean(mean(Diff))

mesh(Diff);
axis([0,21,0,21,-2,1]);
print("../tmp/Diff.pdf");


%  6.1e
Diff = zeros(19,1);

z=5;
for sigma=0.2:0.1:2;
  psi=exp(-0.5*((x-z)/sigma).^2);
  psi=psi/sqrt(psi*psi');
  Diff(round(sigma*10-1))=abs(psi*(C-eye(N))*psi');
end

semilogy([0.2:0.1:2.0],Diff);
print("../tmp/plot.pdf");


% 6.2a

eigen_values = zeros(3,4);

function [H] = homo_osc(alpha , L = 20, N = 151)
  if ~mod(N,2)
    error('N muss ungerade sein')
  end
  M=(N-1)/2;
  a = L/N;
  x=a*(-M:M);
  p=(2*pi/L)*(-M:M);

  %  kinetischer Teil des Hamilton:
  A = H = zeros(N,N);
  for i=[1:N]
    A(i,:) = x(i) - x; % Matrix (x_i - x_j)
  end

  for i=[1:N]
    H += p(i)^2*cos(p(i)*A); % kein i*sin wg. p<->-p Symm.
  end
  H = H*(0.5/N); % (-1/2) Laplace

  %  Potential, Oszillator Teil des Hamilton:
  H += 0.5*diag(abs(x).^alpha);
end

for alpha = [1:4]
  eigen_values(:,alpha) = eig(homo_osc(alpha))(1:3);
end
eigen_values

% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
