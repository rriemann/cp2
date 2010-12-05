% setzt einen rechteckigen schwarzen Rand
function rawprint = cut_rect(rawprint,rho2)
  rho = sqrt(rho2);
  nrpixels = size(rawprint);
  framewidth = round(nrpixels(2)*(1-rho)/2)
  frameheight = round(nrpixels(1)*(1-rho)/2)

  rawprint(:,[1:framewidth,nrpixels(2)-framewidth+1:end]) = 0; % vertikaler rand
  rawprint([1:frameheight,nrpixels(1)-frameheight+1:end],:) = 0; % horizontaler rand
end
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;