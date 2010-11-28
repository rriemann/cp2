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


%  4.1b
figure(1);
fig = gcf;
set(fig, "visible", "off");

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


%  4.1c
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
clf;

% 4.2

data = load("../data/chaosdata.mat");
N = 1501;
a = 0.2;
L = a*N;
f = ruecktrafo(data.y(:,1),a);
w = 2*pi/L*[[0:a:(N-1)/2*a],[-(N-1)*a:a:-(N+1)/2*a]]';
semilogy(w,(abs(f)).^2, '@');
axis([-8, 8,1e-2,1e4]);
print("chaosdata_trafo.png");
