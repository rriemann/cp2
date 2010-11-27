% function to transform given f to fbar

function f = trafo(fbar,L)
  dimfbar = size(fbar)(1);
  f = zeros(dimfbar,1);

  for i = 1:dimfbar,
    for j = 1:dimfbar,
      f(i) = 1/L*exp(sqrt(-1)*2*pi*(i-1)/dimfbar*j)*fbar(i);
    end
  end
