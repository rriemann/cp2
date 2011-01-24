%  Berechnung des Kugelvolumens

N = 1e4;
phi = pi*rand(1,N)/2; % nur [0,90] grad
theta = acos(rand(1,N)); % nur [0,90] grad
global B = 2;
global L = 5;
global R = 0.1;
global theta_c = atan(R/L); % falls theta < theta_c: l = 0
lamda = 1.5;
mean_p  = 0;
mean_p2 = 0;

function l = length(theta,phi)
  global B L R theta_c;

  if theta <= theta_c % teilchen verlaueft nur im Rohr
    l = 0;
    return;
  end

  if phi > pi/4
    phi = pi/2 - phi;
  end
  B_2d = B/cos(phi); % neues B for 2D Rechnung in x-z Ebene

  theta_c2 = atan(B_2d/L); % falls theta < theta_c2: Teilchen trifft End-Cap.

  tt = tan(theta);

  z_rohr = R/tt;
  l_rohr = sqrt(z_rohr^2+R^2);

  if theta <= theta_c2 % Teilchen trifft End-Cap, aber nicht das Rohr.
    x = L*tt;
    l_ges = sqrt(x^2+L^2);
  else % Teilchen trifft Mantelflaeche des Detektors
    z = B_2d/tt;
    l_ges = sqrt(z^2+B_2d^2);
  end
  l = l_ges - l_rohr;
end

p_int = 0
for i=[1:N]
  p = 1-exp(-length(theta(i),phi(i))/lamda);
  p_int   += p;
  mean_p  += p;
  mean_p2 += p^2;
end
A  = p_int/N
dA = sqrt(abs(mean_p2/N - (mean_p/N)^2)/N)



% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;