%  Berechnung des Kugelvolumens

R = 2;
R2 = R^2;
a = R;			% a = 1;
a2 = a^2;
N = 1e4;
M = 5;
hit_kugel = 0;
J = 0;

x  = R*rand(1,N);	% nur positive achsen
x2 = x.^2;
y2 = R2*rand(1,N).^2;
z2 = R2*rand(1,N).^2;


for j=[1:M]
  for i=[1:N]
    if x(i) <= a && x2(i) + y2(i) + z2(i) <= R2
      hit_kugel += 1;
      J += x2(i) + y2(i);
    end
  end
end

V = hit_kugel/N*R^2*a*8/M
J = J/N*V/M

%  exakte Ergebnisse fuer a=R
V_ex = 4/3*pi*R^3
J_ex = 2/5*V_ex*R^2

% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;