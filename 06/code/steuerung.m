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

% 6.2a

function [H] = homo_osc(alpha = 2, L = 20, N = 151)
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

eigen_values = zeros(4,3);
for alpha = [1:4]
  eigen_values(alpha,:) = eig(homo_osc(alpha))(end-2:end)';
end

% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;