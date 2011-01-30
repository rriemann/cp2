%  Berechnung des Kugelvolumens und des Traegheitsmoments
clear all;
a = R = 2;

function sphere(R,a)
  a2 = a^2;
  R2 = R^2;
  N = 1e4;
  M = 5;

  disp('exakte Ergebnisse');
  V_ex = 4/3*pi*R^3 - 2/3*pi*(R-a)^2*(2*R+a)
  if a == R
    J_ex = 2/5*V_ex*R^2
  end
  V = J = zeros(1,M);
  var_V = zeros(1,M);
  var_J = zeros(1,M);
  norm = 1/N*R2*a*8;

  for j=[1:M]
    x2  = a2*rand(1,N).^2;   % nur positive achsen
    y2  = R2*rand(1,N).^2;
    z2  = R2*rand(1,N).^2;
    J_allvalues = zeros(1,N);
    hit_kugel   = 0;
    J_r2 = 0;
    for i=[1:N]
      if x2(i) + y2(i) + z2(i) <= R2
        ++hit_kugel;
        J_r2 += x2(i) + y2(i);
      end
      J_allvalues(i) = (x2(i)+y2(i)+z2(i) <= R2) * (x2(i)+y2(i)) * norm;
    end
    V(j) = hit_kugel*norm;
    J(j) = J_r2*norm;

    var_V(j) = (V(j) - V_ex)^2;
    if a==R
      var_J(j) = (J(j) - J_ex)^2;
    else
      var_J(j) = abs(sum(J_allvalues.^2)/N - J(j)^2);
    end

  end

  mean(V)
  sqrt(mean(var_V))
  mean(J)
  if a == R
    sqrt(mean(var_J))
  else
    sqrt(mean(var_J)/N)
  end
end

sphere(2,2); % R = 2, a = 2
sphere(2,1); % R = 2, a = 1
