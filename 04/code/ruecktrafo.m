% function to retransform given fbar to f

function fbar = ruecktrafo(f,a)
  dimf = size(f)(1);
  fbar = zeros(dimf,1);

  for i = 1:dimf,
    for j = 1:dimf,
      fbar(i) = a*exp(-sqrt(-1)*2*pi*(i-1)/dimf*j)*fbar(i);
    end
  end
 
