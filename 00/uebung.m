#!/usr/bin/octave -q
# kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
clear;
disp('Aufgabe 0.2');

global minus_g_per_l = -9.81/1;

t0 = 0;
tend = 8;
x10 = pi/180*45;
x20 = 0;

function res = ableitung(t,x)
  global minus_g_per_l;
  res = [x(2),minus_g_per_l*sin(x(1))];
end
function res = ableitung2(t,x)
  global minus_g_per_l;
  res = [x(2),minus_g_per_l*x(1)];
end

options = odeset('RelTol',1e-6, 'AbsTol', 1e-6, 'MaxStep', 0.1, 'InitialStep', 0.001);
[t,x] = ode45(@ableitung,  [t0, tend], [x10, x20], options);
[u,y] = ode45(@ableitung2, t, [x10, x20], options);

%  erste Möglichkeit
figure(1);
subplot(2,1,1);
plot(t, x(:,1),'b');
subplot(2,1,2);
plot(u, y(:,1),'b');

%  zweite Möglichkeit
%  figure(1);
%  plot(t, x(:,1), y(:,1),'br');
fig = gcf;
set(fig, "visible", "off");

print('figure.png')