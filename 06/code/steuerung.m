%  aufgabe 6.1a)
[a,x,p,H] = ho_fou(10,11);


%  6.2a)
C = i*(p*x-x*p);

figure(1);
fig = gcf;
set(fig, "visible", "off");

mesh(real(x),real(C));
print("../tmp/mesh_c_over_x.pdf");
mesh(real(C));
print("../tmp/mesh_c.pdf");
