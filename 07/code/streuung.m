clear all; clf;
L=30; N=201; V0 = 3; w = 1; m = 0;
j = sqrt(-1);
T0 = 2*pi;
T = T0/10;
x_z=3;
sigma=1/sqrt(3);

for n = [10 2 1]
  [a,x,H] = ho_fou(L,N,n);

  U = expm(-j*T*H);
  [eig_vec, eig_val] = eig(H);
  eig_val = diag(eig_val);
  
  k_pos = sqrt(2*eig_val(mean(abs(eig_vec(:,:) - eig_vec(end:-1:1,:))) < 10^-10));	% ka, wo das genau herkommt. aus absprache mit anderen entstanden
  k_neg = sqrt(2*eig_val(mean(abs(eig_vec(:,:) - eig_vec(end:-1:1,:))) > 10^-10));	% man sieht halt, dass das was mit der symmetrie zu tun hat. symmetrisch -> kleine differenz mit gespiegeltem vektor, etc
  
  delta_pos = -0.5*angle(exp(-j*k_pos*L));
  delta_neg = -0.5*angle(exp(-j*k_neg*L));
  
  plot(k_neg, delta_neg, 'rx'); hold on;
  plot(k_pos, delta_pos, 'b+');

  psi = exp(-(x-x_z).^2/(2*sigma^2)).';
  psi = psi/norm(psi);
  gauss=psi;
  p = psi.*conj(psi);	% Wahrscheinlichkeit

%    hold off;
  plot(x,p,'-');
  hold on;

  t=0;
  for i=1:5
    psi = U*psi; t=t+T;
    p = psi.*conj(psi);
    plot(x,p,'-');
%      pause(1);
  end

  xlabel('x'); ylabel('p');
%    pause;
  
  if (n == 1)  
    k = 0.001:0.01:max([max(k_pos), max(k_neg), m]);
    k_step = sqrt(k.^2 - 2*V0);
    phase_step_pos = -0.5*angle(exp(-2*j*k*w).*(k+j*k_step.*tan(k_step*w))./(k-j*k_step.*tan(k_step*w)) );
    phase_step_neg = -0.5*angle(-exp(-2*j*k*w).*(k-j*k_step.*cot(k_step*w))./(k+j*k_step.*cot(k_step*w)) );
    
    delta_neg_born = -0.5*angle(exp(2*j*V0./(4*k.^3*w) .* (-1+cos(2*k*w)-2*k.^2*w^2) ));
    delta_pos_born = -0.5*angle(exp(2*j*V0./(4*k.^3*w) .* (1-cos(2*k*w)-2*k.^2*w^2) ));
    
    plot(k, phase_step_pos, 'r');
    plot(k, phase_step_neg, 'b');
    plot(k, delta_pos_born, 'g--');
    plot(k, delta_neg_born, 'g--');
  end
  
  hold off;
end
