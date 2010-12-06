% setzt einen kreisfoermigen schwarzen Rand
function rawprint = cut_rect(rawprint,rho2)
  rho = sqrt(rho2);
  nrpixels = size(rawprint);

  %  http://programming.itags.org/matlab/11049/
  r = sqrt(4/pi)*rho; % h*w = (1-(-1))^2
  x = linspace(-1,1,nrpixels(2));
  y = linspace(-1,1,nrpixels(1));
  [X,Y] = meshgrid(x,y);
  R = sqrt(X.^2 + Y.^2);
  R(R>r) = 0;
  R(find(R)) = 1;
  rawprint = rawprint.*R;
end
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;