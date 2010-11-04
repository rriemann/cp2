%!/usr/bin/octave -q
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;

function res = eig_custom(A)
  % berechnet zu einer reellen, symmetrischen Matrix (A = A^T) die Eigenwerte
  % und gibt sie in einer Diagonalmatrix wieder zurück.

  max_iterations = 1e5;
  A = (A + A.')/2;

  n = size(A)(1);
  A1 = A;
  # A1 = zeros(n);
  iterations = 0;

  % berechne S(A):
  A2 = A.^2;
  ss = sum(sum(A2))-trace(A2); % ineffizient, da Spur-Elemente doppelt berechnet werden

  while iterations < max_iterations
    #fuer aufgabe b)
    V = eye(n);
    counter = 0;
    
    if ss > 10*eps*(n^2-n)
      for q = [2:n]
        for p = [1:q-1]
          if A(p,q) ~= 0
            theta = (A(q,q)-A(p,p))/(2*A(p,q));
            t = sign(theta)/(abs(theta)+sqrt(theta^2+1));
            c = 1/sqrt(t^2+1);
            s = t*c;
            
            if counter == 0
              V(p,p) = c;
              V(p,q) = s;
              V(q,p) = -s;
              V(q,q) = c;
            end
            counter = 1;
            
            tau = s/(1+c);
            #A1
            for i = [[1:p-1], [p+1:q-1], [q+1:n]]
              A1(i,p) = A(i,p)-s*(A(i,q)+tau*A(i,p));
              A1(p,i) = A1(i,p);
              A1(i,q) = A(i,q)+s*(A(i,p)-tau*A(i,q));
              A1(q,i) = A(i,q);
              if counter > 0
                V(i,p) = V(p,p)*c - V(q,p)*s;
                V(i,q) = V(p,q)*c + V(q,q)*s;
              end
            end
            #A1
            A1(p,p) = A(p,p)-t*A(p,q);
            A1(q,q) = A(q,q)+t*A(p,q);
            A1(p,q) = 0;
            A1(q,p) = 0;
            #[q,p]
            #A
            #A1
            #pause;
          end
        end
      end
      ss = ss - 2*A(p,q)^2;
      A = A1;
      iterations = iterations + 1;
    else
      break;
    end
  end
  disp('Iterationen:');
  disp(iterations);
  A*A'
  res = A;
end
