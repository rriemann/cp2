#!/usr/bin/octave -q
# kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;

function res = eig_custom(A)
  # berechnet zu einer reellen, symmetrischen Matrix (A = A^T) die Eigenwerte
  # und gibt sie in einer Diagonalmatrix wieder zurück.

  size = size(A)(1);
  A1 = zeros(size);
  max_iterations = 1e3;
  iterations = 0;
  while iterations < max_iterations
    if SS(A) > 10*eps*(size^2-size)
      for q = [2:size]
        for p = [1:q-1]
          # disp([q, p]);
          theta = (A(q,q)-A(p,p))/(2*A(p,q));
          t = sign(theta)/(abs(theta)+sqrt(theta^2+1));
          c = 1/sqrt(t^2+1);
          s = t*c;
          tau = s/(1+c);
          for i = [[1:p-1], [p+1:q-1], [q+1:size]]
            A1(i,p) = A(i,p)-s*(A(i,q)+tau*A(i,p));
            A1(i,q) = A(i,q)+s*(A(i,p)-tau*A(i,q));
          end
          A1(p,p) = A(p,p)-t*A(p,q);
          A1(q,q) = A(q,q)+t*A(p,q);
          A1(p,q) = 0;
        end
      end
      A = A1;
      iterations += 1
    else
      break;
    end
  end
  disp('Iterationen:');
  disp(iterations);
  res = A;
end
