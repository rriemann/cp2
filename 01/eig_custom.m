% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;

function res = eig_custom(A)
  % res = eig_custom(A)
  % berechnet zur (nxn)-Matrix (A+A')/2 die Eigenwerte
  % und gibt sie als sortieren Spaltenvektor res aus

  A = (A + A.')/2;
  Abak = A;

  n = size(A)(1);
  A1 = A;
  V = V1 = eye(n);
  iterations = 0;

  % berechne S(A):
  A2 = A.^2; % flops: n^2
  ssum = sum(sum(A2))-trace(A2); % ineffizient, da 2mal Spur-Elemente-Berechnung
  ssum_min = eps*(n^2-n);

  while ssum > ssum_min
    for q = [2:n] % flops: *(n-1)
      for p = [1:q-1] % flops: *(q-1)
          theta = (A(q,q)-A(p,p))/(2*A(p,q)); % flops: 2
          t = sign(theta)/(abs(theta)+sqrt(theta^2+1)); % flops: 2
          c = 1/sqrt(t^2+1); % flops: 2
          s = t*c; % flops: 1
          tau = s/(1+c); % flops: 1

          % Berechnung der Eigenvektoren
          V1(:,p) += -s*(V(:,q)+tau*V(:,p));
          V1(:,q) += +s*(V(:,p)-tau*V(:,q));
          V = V1;

          % Diagonalisierung nach Jacobi-Methode
          i = [[1:p-1], [p+1:q-1], [q+1:n]]; % flops: *n
          A1(i,p) = A1(p,i) = A(i,p)-s*(A(i,q)+tau*A(i,p)); % flops: 2
          A1(i,q) = A1(q,i) = A(i,q)+s*(A(i,p)-tau*A(i,q)); % flops: 2

          A1(p,p) = A(p,p)-t*A(p,q); % flops: 1
          A1(q,q) = A(q,q)+t*A(p,q); % flops: 1
          A1(p,q) = A1(q,p) = 0;

          ssum -= 2*abs(A(p,q)^2); % flops: 2
          A = A1;
      end
    end
    iterations++;
  end
  disp('Iterationen:');
  disp(iterations);
  disp('V''*A*V:');
  disp(V.'*Abak*V);
  disp('V''*V:');
  disp(V'*V);
  res = sort(diag(A));
  disp('res-eig(A):');
  disp(res-eig(Abak));
end
