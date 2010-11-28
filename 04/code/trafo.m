% function to transform given f to fbar
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;

function f = trafo(fbar,L)
  dimfbar = size(fbar)(1);
  f = 1/L*exp(2*pi*i*[0:dimfbar-1]'*[0:dimfbar-1]/dimfbar)*fbar;
end
