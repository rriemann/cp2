#!/usr/bin/octave -q
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
clear;

global g nu;
g=0.32; nu=0.3;

function yp = F_ex(t,y)
  global g nu;
  position = [y(1);y(3)];
%    if ((abs(position(1)-position(2))) >= 0.1)
%      break;
%    end
  speed = [y(2);y(4)];
  acceleration = g*sin(t)-nu*speed-position.*(position.^2-1);
  yp = [speed(1);acceleration(1);speed(2);acceleration(2)];
end

% /usr/share/octave/packages/odepkg-0.6.10/doc/odepkg.pdf
function [veve, vterm, vdir] = feve (t, y, varargin)
  veve = 0.1-abs(y(1)-y(3));
%    veve = vy(1); % Which event component should be tread
  vterm = 1; % Terminate if an event is found
  vdir = -1; % In which direction, -1 for falling
end

t_span = [0 300];
ep = 1e-6;
iterations = 200;
options = odeset ('Events',@feve,'RelTol',1e-6, 'AbsTol', 1e-6, 'MaxStep', 1, 'InitialStep', 0.1);
t_break = zeros(1,iterations);
for i = [1:iterations]
  % Anfangswerte:
  y0 = [randn() ; randn()];
  y1 = [y0(1)-ep*randn(); y0(2)-ep*randn()];      %war das so gemeint?

  % Integration:
  [t,y] = ode45(@F_ex,t_span,[y0;y1],options);  %funktioniert so wohl nicht. man muss wohl ode 2mal aufrufen, für jedes y0/1 einmal
  t_break(i) = t(end);
end
t_min = min(t_break);
t_max = max(t_break);

% Plotting
figure(1);
x = [t_min:iterations/(t_max-t_min)*5:t_max];
hist(t_break,x);
fig = gcf;
set(fig, "visible", "off");
print('figure.png')

% Statistics:
t_mean = mean(t_break)
t_std = std(t_break) % using N-1 by default

% lamda calculations
lamda = (log(0.1)-log(ep))./t_break;
lamda_mean = mean(lamda)
lamda_std = std(lamda)




