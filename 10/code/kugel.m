%  Berechnung des Kugelvolumens

R = 2;
R2 = R^2;
a = R;			% a = 1;
a2 = a^2;
N = 1e4;
M = 5;
sum_f = 0;

x2 = R2*rand(1,N).^2;	% nur positive achsen
y2 = R2*rand(1,N).^2;
z2 = R2*rand(1,N).^2;

for i=[1:N]
  if x(i) <= a && x2(i) + y2(i) + z2(i) <= R2
    sum_f += 1;
  end
end

sum_f

V = sum_f/N*R2*a*8
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;