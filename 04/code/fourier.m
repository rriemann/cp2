%  4.1
disp("Vektor eins: ");
v1 = [1;2;3;4;5]
f1 = trafo(v1,5)

ruecktrafo(f1,1)

disp("Vektor zwei: ");
v2 = [-0.1;0.75;pi]
f2 = trafo(v2,3)

ruecktrafo(f2,1)


%  4.2

T = 10;
N = 101;
w0 = 2*pi/T;

sinfkt = sin(w0*[0:T/(N-1):T]');
%  w = trafo([0:T/(N-1):T]',T);		% berechnung der omegas. korrekt?
% w entspricht k in der umgesetzten formel. daher ist w = 2pi/T*n mit n = [0:100]
w = 2*pi/T*[0:100]';
f = trafo(sinfkt,1);
plot(w,(abs(f)).^2);			% ka, ob das zu erwarten war ;)
print("sintrafo.png");