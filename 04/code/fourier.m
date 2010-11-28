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
% w entspricht k in der umgesetzten formel. daher ist w = 2pi/T*n mit n = [0:100]
w = 2*pi/T*[[0:50],[-50:-1]]';
f = ruecktrafo(sinfkt,1);
semilogy(w,(abs(f)).^2, '@');
axis([-30, 30,1e-2,1e4])
print("sintrafo.pdf");
clf;


%  4.1c
gamma = 0.5;
fkt = sin(w0*[0:T/(N-1):T]').*exp(-gamma*w0*[0:T/(N-1):T]');
f = ruecktrafo(fkt,1);
semilogy(w,(abs(f)).^2, '@');
print("daempfung.png");

w0 = 4.5*2*pi/T;
sinfkt = sin(w0*[0:T/(N-1):T]');
f = ruecktrafo(sinfkt,1);
semilogy(w,(abs(f)).^2, '@');
print("sintrafo2.png");
clf;

% 4.2

data = load("../data/chaosdata.mat");
N = 1501;
a = 0.2;
L = a*(N-1);
f = ruecktrafo(data.y(:,1),a);
ww = a*[-(N-1)/2:(N-1)/2]';
w = [ww((N-1)/2+1:end);ww(1:(N-1)/2)];
semilogy(w,(abs(f)).^2, '+', "markersize", 6);
axis([-75, 75,1e-2,1e4]);
print("chaosdata_trafo_log.pdf");
clf;
plot(w,(abs(f)).^2, '+', "markersize", 6);
axis([-15, 15])
print("chaosdata_trafo.pdf");
