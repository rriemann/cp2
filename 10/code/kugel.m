%  Berechnung des Kugelvolumens

R = 2;
a = R;			% a = 1;
N = 1e4;
M = 5;
hit_kugel = 0;
J = 0;

x = R*rand(1,N);	% nur positive achsen
y = R*rand(1,N);
z = R*rand(1,N);

for j=[1:M]
  for i=[1:N]
    if x(i) <= a && x(i)*x(i) + y(i)*y(i) + z(i)*z(i) <= R*R
      hit_kugel += 1;
      J += x(i)*x(i) + y(i)*y(i);
    end
  end
end

V = hit_kugel/N*R^2*a*8/M
J = J/N*V/M


%  exakte Ergebnisse fuer a=R
V_ex = 4/3*pi*R^3
J_ex = 2/5*V_ex*R^2