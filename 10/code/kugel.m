%  Berechnung des Kugelvolumens

R = 2;
a = R;			% a = 1;
N = 1e4;
M = 5;
sum_f = 0;

x = R*rand(1,N);	% nur positive achsen
y = R*rand(1,N);
z = R*rand(1,N);

for i=[1:N]
  if x(i) <= a && x(i)*x(i) + y(i)*y(i) + z(i)*z(i) <= R*R
    sum_f += 1;
  end
end

sum_f

V = sum_f/N*R^2*a*8