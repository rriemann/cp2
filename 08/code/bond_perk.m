#!/usr/bin/env octave
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
L=10;  % Gittergroesse L*L
p=0.4;  % Besetzungswahrscheinlichkeit
rand('state',0); % Standard initialisierung der Zufallszahlen

disp('Bondbesetzung:');
%  nach oben und rechts: wert = -3, wenn nur rechts: wert = -2, nur oben: -1; passiv: 0
feld_rechts = (rand(L,L-1) < p); % 1 = verbindung nach rechts
feld_oben = (rand(L-1,L) < p); % 1 = verbindung nach links
feld = zeros(L,L);
for i=1:L-1
  feld(:,i) -= 2*feld_rechts(:,i);
  feld(i,:) -= feld_oben(i,:);
end
flipud(feld)  % druck-plot gegen (x,y), (0,0) unten links.

% Plot
figure();axis([0 L+1 0 L+1]);hold on;
% Plot von Punkten und Linien
for x=1:L, for y=1:L
    plot(x,y,'*r');
    if rem(feld(y,x),2) == -1 % verbindung nach oben
      plot([x x],[y y+1],'-b');
    end
    if feld(y,x) < -1 % verbindung nach rechts
      plot([x x+1],[y y],'-b');
    end
end,end
axis off;

pause

disp('Ergebnis, Baumsuche:');
[feld] = baum_analyse(feld);
flipud(feld.')

%
%  disp('Ergebnis, Baumsuche:');
%  [feld] = baum_analyse(feld);
%  flipud(feld.')
%  disp('Ergebnis, Hoshen-Kopelman:');
%  [feld] = hoshen_kopelman(feld);
%  flipud(feld.')