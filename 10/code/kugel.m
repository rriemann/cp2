%  Berechnung des Kugelvolumens

disp('exakte Ergebnisse fuer a=R=2');
R = a = 2;
V_ex = 4/3*pi*R^3
J_ex = 2/5*V_ex*R^2

function sphere(R,a)
  a2 = a^2;
  R2 = R^2;
  N = 1e4;
  M = 5;
  V = J = zeros(1,M);
  norm = 1/N*R2*a*8;
  for j=[1:M]
    x2 = R2*rand(1,N).^2;   % nur positive achsen, da sowieso quadriert wird
    y2 = R2*rand(1,N).^2;
    z2 = R2*rand(1,N).^2;
    hit_kugel = 0;
    J_r2 = 0;
    for i=[1:N]
      if x2(i) + y2(i) + z2(i) <= R2
        ++hit_kugel;
        J_r2 += x2(i) + y2(i);
      end
    end
    V(j) = hit_kugel*norm;
    J(j) = J_r2*norm;
  end
  mean(V)
  mean(J)
end

sphere(2,2); % R = 2, a = 2
sphere(2,1); % R = 2, a = 1

% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
