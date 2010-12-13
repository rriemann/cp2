function [H] = homo_osc(alpha,L,N)
  if ~mod(N,2)
    error('N muss ungerade sein')
  end
  M=(N-1)/2;
  a = L/N;
  x=a*(-M:M);
  p=(2*pi/L)*(-M:M);

  %  kinetischer Teil des Hamilton:
  H = zeros(N,N);
  A = zeros(N,N);
  for i=[1:N]
    A(i,:) = x(i) - x; % Matrix (x_i - x_j)
  end

  for i=[1:N]
    H = H + p(i)^2*cos(p(i)*A); % kein i*sin wg. p<->-p Symm.
  end
  H = H*(0.5/N); % (-1/2) Laplace

  %  Potential, Oszillator Teil des Hamilton:
  H = H + 0.5*diag(abs(x).^alpha);
end