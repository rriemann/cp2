%  aufgabe 6.1a)
[a,x,p] = ho_fou(10,11);


%  6.2a)
C = i*(p*x-x*p);

figure(1);
fig = gcf;
set(fig, 'visible', 'off');

mesh(real(x),real(C));
print('../tmp/mesh_c_over_x.pdf');
mesh(real(C));
zlabel('C');
print('../tmp/mesh_c.pdf');


%  6.1d
L = 20;
N = 101;                % oder 201 und 1001
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
xlabel('z1');
ylabel('z2');
zlabel('<a|C|b> - <a|b>');
print('../tmp/Diff.pdf');


%  6.1e
Diff = zeros(19,1);

z=5;
for sigma=0.2:0.1:2;
  psi=exp(-0.5*((x-z)/sigma).^2);
  psi=psi/sqrt(psi*psi');
  Diff(round(sigma*10-1))=abs(psi*(C-eye(N))*psi');
end

semilogy([0.2:0.1:2.0],Diff);
print('../tmp/plot.pdf');


% 6.2a

eigen_values = zeros(3,4);

for alpha = [1:4]
  ee = eig(homo_osc(alpha,20,151));
  eigen_values(:,alpha) = ee(1:3);
end
eigen_values

% 6.2b

N = [21:2:101];
eigen_values = zeros(3,length(N));
for n = 1:length(N)
  H = homo_osc(4.0, 20, N(n));
  ee = eig(H);
  ee = sort(ee);
  eigen_values(:,n) = ee(1:3);
end
clf;
format = ['*','+','.'];
for i = [1:3]
  eigen_values(i,:) = abs(eigen_values(i,:)-mean(eigen_values(i,end-4:end)))/mean(eigen_values(i,end-4:end));
  semilogy(N,eigen_values(i,:),format(i));
  hold on;
end
legend('1. Eigenwert','2. Eigenwert','3. Eigenwert');
xlabel('N');
ylabel('relative Abweichung');

print('../tmp/plot62b.pdf');

% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
