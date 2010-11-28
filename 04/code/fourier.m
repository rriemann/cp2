% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
%  4.1
disp("Vektor eins: ");
v1 = [1;2;3;4;5]
f1 = trafo(v1,5)

ergebnis = ruecktrafo(f1,1)

disp("Vektor zwei: ");
v2 = [-0.1;0.75;pi]
f2 = trafo(v2,3)

ergebnis = ruecktrafo(f2,1)


%  4.2

T = 10;
N = 101;
w0 = 5*2*pi/T;

sinfkt = sin(w0*[0:T/(N-1):T]');
%  w = trafo([0:T/(N-1):T]',T);		% berechnung der omegas. korrekt?
% w entspricht k in der umgesetzten formel. daher ist w = 2pi/T*n mit n = [0:100]
w = 2*pi/T*[[0:50],[-50:-1]]';
f = trafo(sinfkt,1);
semilogy(w,(abs(f)).^2, '@');
axis([-30, 30,1e-5,1e5])
print("sintrafo.png");


%  4.3
gamma = 0.5;
fkt = sin(w0*[0:T/(N-1):T]').*exp(-gamma*w0*[0:T/(N-1):T]');
f = trafo(fkt,1);
semilogy(w,(abs(f)).^2, '@');
print("daempfung.png");

w0 = 4.5*2*pi/T;
sinfkt = sin(w0*[0:T/(N-1):T]');
f = trafo(sinfkt,1);
semilogy(w,(abs(f)).^2, '@');
print("sintrafo2.png");