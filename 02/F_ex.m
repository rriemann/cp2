% file F_ex.m
% Kraft fuer das 1. Beispiel Chaos

function yp = F_ex(t,y)

y0 = y(:,1);
y1 = y(:,2);

global g nu
c0 = g*sin(t) - nu*y0(2) -y0(1)*(y0(1)*y0(1)-1.0);
yp(:,1) = [y0(2) ; c0];
c1 = g*sin(t) - nu*y1(2) -y1(1)*(y1(1)*y1(1)-1.0);
yp(:,2) = [y1(2) ; c1]; 

if (abs(c0-c1) >= 0.1)
  break;
end
