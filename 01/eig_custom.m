%!/usr/bin/octave -q
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;

function res = eig_custom(A)
  % berechnet zu einer reellen, symmetrischen Matrix (A = A^T) die Eigenwerte
  % und gibt sie in einer Diagonalmatrix wieder zurück.

  max_iterations = 1e5;
  A = (A + A.')/2;
  Abak = A;

  n = size(A)(1);
  A1 = A;
  V = eye(n);
  V1 = V;
  iterations = 0;

  % berechne S(A):
  A2 = A.^2;
  ssum = sum(sum(A2))-trace(A2); % ineffizient, da Spur-Elemente doppelt berechnet werden

  while abs(ssum) > 10*eps*(n^2-n)

      for q = [2:n]
        for p = [1:q-1]
            theta = (A(q,q)-A(p,p))/(2*A(p,q));
            t = sign(theta)/(abs(theta)+sqrt(theta^2+1));
            c = 1/sqrt(t^2+1);
            s = t*c;
            tau = s/(1+c);

            for i = [[1:p-1], [p+1:q-1], [q+1:n]]
              A1(i,p) = A(i,p)-s*(A(i,q)+tau*A(i,p));
              A1(p,i) = A1(i,p);
              A1(i,q) = A(i,q)+s*(A(i,p)-tau*A(i,q));
              A1(q,i) = A1(i,q);

              V1(i,p) = V(i,p) - s*(V(i,q) + tau*V(i,p));
              V1(i,q) = V(i,q) + s*(V(i,p) - tau*V(i,q));
              V = V1;

            end
            A1(p,p) = A(p,p)-t*A(p,q);
            A1(q,q) = A(q,q)+t*A(p,q);
            A1(p,q) = 0;
            A1(q,p) = 0;
            ssum = ssum - 2*abs(A(p,q)^2);
            A = A1;
        end
      end
      iterations = iterations + 1;
  end
  disp('Iterationen:');
  disp(iterations);
  V'*Abak*V
  V'*V
  res = A;
end
