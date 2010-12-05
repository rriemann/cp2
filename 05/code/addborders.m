raw = double(imread('../data/testbild.tif','TIF'));
whos raw % zeige matrix an

colormap('Gray');
image(raw); title('Original');

nrpixels = size(raw);
rho = [0.01:0.01:1]';

% gleich für alle rho-werte (klappt noch nicht)
%  raw(:,round(nrpixels(2)*(1.-rho)/2)) = 0;		% linker rand
%  raw(:,round(nrpixels(2)*(1.-(1.-rho)/2))) = 0;		% rechter rand
%  raw(round(nrpixels(1)*(1.-rho)/2),:) = 0;		% oberer rand
%  raw(round(nrpixels(1)*(1.-(1.-rho)/2)),:) = 0;		% unterer rand

rho = sqrt(0.4);
rawprint = raw;
framewidth = round(nrpixels(2)*(1-rho)/2)
frameheight = round(nrpixels(1)*(1-rho)/2)

rawprint(:,1:framewidth) = 0;				% linker rand
rawprint(:,(nrpixels(2)-framewidth:nrpixels(2))) = 0;			% rechter rand
rawprint(1:frameheight,:) = 0;				% oberer rand
rawprint(nrpixels(1)-frameheight:nrpixels(1),:) = 0;		% unterer rand

imwrite(rawprint,'../tmp/eins_a.tif','TIF');