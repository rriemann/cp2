#!/usr/bin/octave -q
# kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;

function res = SS(A)
  A2 = A.^2;
  res = sum(sum(A2))-trace(A2); # ineffizient, da Spur-Elemente doppelt berechnet werden
end