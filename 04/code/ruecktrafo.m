% function to retransform given fbar to f
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;

function f = ruecktrafo(fbar,a)
  dimfbar = size(fbar)(1);
  f = a*exp(2*pi*i*[0:dimfbar-1]*[0:dimfbar-1]/dimfbar)*fbar;
end