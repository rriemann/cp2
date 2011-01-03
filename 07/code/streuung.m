#!/usr/bin/env octave
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
clear all; clf;
figure(1); fig = gcf; set(fig, 'visible', 'off');

% Aufgabe 7.1 a)
L=30; N=201; V0 = 3; w = 1; m = 0;
j = sqrt(-1);
T0 = 2*pi;
T = T0/10;
x_z=3;
sigma=1/sqrt(3);

for n = [10 2 1]
  hold off;
  [a,x,H] = ho_fou(L,N,n);

  U = expm(-j*T*H);
  [eig_vec, eig_val] = eig(H);
  eig_val = diag(eig_val);

  k_pos = sqrt(2*eig_val(mean(abs(eig_vec(:,:) - eig_vec(end:-1:1,:))) < 10^-10));
  k_neg = sqrt(2*eig_val(mean(abs(eig_vec(:,:) - eig_vec(end:-1:1,:))) > 10^-10));

  delta_pos = -0.5*angle(exp(-j*k_pos*L));
  delta_neg = -0.5*angle(exp(-j*k_neg*L));

  plot(k_neg, delta_neg, 'rx','markersize',3); hold on;
  plot(k_pos, delta_pos, 'b+','markersize',3);

  k = 0.001:0.01:max([max(k_pos), max(k_neg), m]);
  k_step = sqrt(k.^2 - 2*V0);
  phase_exakt_pos = -0.5*angle(exp(-2*j*k*w).*(k+j*k_step.*tan(k_step*w))./(k-j*k_step.*tan(k_step*w)) );
  phase_exakt_neg = -0.5*angle(-exp(-2*j*k*w).*(k-j*k_step.*cot(k_step*w))./(k+j*k_step.*cot(k_step*w)) );

  plot(k, phase_exakt_pos, 'r--','linewidth',3);
  plot(k, phase_exakt_neg, 'b--','linewidth',3);

  xlabel('k'); ylabel('\delta');
  legend('\delta_{-}','\delta_{+}','\delta_{+, exakte Stufe}','\delta_{-, exakte Stufe}');
  print(['../tmp/71a_n', int2str(n), '.pdf']);

  if (n == 1)
    % Aufgabe 7.1 b)

    delta_neg_born = -0.5*angle(exp(2*j*V0./(4*k.^3*w) .* (-1+cos(2*k*w)-2*k.^2*w^2) ));
    delta_pos_born = -0.5*angle(exp(2*j*V0./(4*k.^3*w) .* (1-cos(2*k*w)-2*k.^2*w^2) ));

    % Aufgabe 7.1 c)

    hold off;
    plot(k_neg, delta_neg, 'rx','markersize',3); hold on;
    plot(k_pos, delta_pos, 'b+','markersize',3);
    plot(k, delta_neg_born, 'k--','linewidth',3);
    plot(k, delta_pos_born, 'g--','linewidth',3);
    xlabel('k'); ylabel('\delta');
    legend('\delta_{-}','\delta_{+}','\delta_{-,Born}','\delta_{+,Born}');
    print('../tmp/71c.pdf');

    hold off;

    % Aufgabe 7.1 d)
    k_step = sqrt(k.^2 - V0);
    delta_pos = -0.5*angle(exp(-j*k_pos*L));
    delta_neg = -0.5*angle(exp(-j*k_neg*L));
    phase_step_pos = -0.5*angle(exp(-2*j*k*w).*(k+j*k_step.*tan(k_step*w))./(k-j*k_step.*tan(k_step*w)) );
    phase_step_neg = -0.5*angle(-exp(-2*j*k*w).*(k-j*k_step.*cot(k_step*w))./(k+j*k_step.*cot(k_step*w)) );

    plot(k_neg, delta_neg, 'rx','markersize',3); hold on;
    plot(k_pos, delta_pos, 'b+','markersize',3);
    plot(k, phase_step_neg, 'k--','linewidth',3);
    plot(k, phase_step_pos, 'g--','linewidth',3);
    xlabel('k'); ylabel('\delta');
    legend('\delta_{-}','\delta_{+}','\delta_{-,exakte Stufe}','\delta_{+,exakte Stufe}');
    print('../tmp/71d.pdf');
  end
end
