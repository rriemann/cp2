% file chaos_ex.m

global g nu
g=0.32; nu=0.3;

for i = [1:100]

  % Anfangswerte:
  y0 = [randn() ; randn()];
  y1 = [y0(1)- 1e-6*randn(); y0(2)- 1e-6*randn()];	%war das so gemeint?
  t0 = 0;

  % Integration:
  tspan=[t0 300];
  yges = [y0, y1];
  [t,y] = ode45(@F_ex,tspan,yges);	%funktioniert so wohl nicht. man muss wohl ode 2mal aufrufen, für jedes y0/1 einmal
  plot(t,y(:,1))
  xlabel("t"); ylabel("y")

end

