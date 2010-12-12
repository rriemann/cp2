%  aufgabe 6.1b)
[a,x,p] = ho_fou(10,11);


%  6.1c)
C = i*(p*x-x*p);

figure(1);
fig = gcf;
set(fig, "visible", "off");

mesh(real(x),real(C));
print("../tmp/mesh_c_over_x.pdf");
mesh(real(C));
print("../tmp/mesh_c.pdf");


%  6.1d
L = 20;
N = 101;
[a,x,p] = ho_fou(L,N);
C = i*(p*x-x*p);
x = sum(x);		% zeilenvektor
Diff = zeros(L);
sigma = 0.5;		% beliebig

for z1 = 1:L+1,
  psi1 = exp(-1/2*(x-(z1-L/2-1)).^2/sigma^2);
  psi1 = psi1/sqrt(psi1*psi1');
  for z2 = 1:L+1,
    psi2 = exp(-1/2*(x-(z2-L/2-1)).^2/sigma^2);
    psi2 = psi2/sqrt(psi2*psi2');
    Diff(z1,z2) = psi1*C*psi2'-psi1*psi2';
  end
end

%  mean(mean(Diff))

mesh(Diff);
axis([0,21,0,21,-2,1]);
print("../tmp/Diff.pdf");


%  6.1e
Diff = zeros(20,1);

z=5;
for sigma=0.1:0.1:2;
  psi=exp(-0.5*((x-z)/sigma).^2);
  psi=psi/sqrt(psi*psi');
  Diff(round(sigma*10))=abs(psi*(C-eye(N))*psi');
end

Diff

semilogy([0.1:0.1:2.0],Diff);
print("../tmp/plot.pdf");