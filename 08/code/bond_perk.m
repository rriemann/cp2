#!/usr/bin/env octave
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
L=10;  % Gittergroesse L*L
p=0.4;  % Besetzungswahrscheinlichkeit
rand('state',0); % Standard initialisierung der Zufallszahlen

disp('Bondbesetzung:');
%  nach oben und rechts: wert = -3, wenn nur rechts: wert = -2, nur oben: -1; passiv: 0
feld_rechts = (rand(L,L-1) > p); % 1 = verbindung nach rechts
feld_oben = (rand(L-1,L) > p); % 1 = verbindung nach links
feld = zeros(L,L);
for i=1:L-1
  feld(i,:) -= 2*feld_rechts;
  feld(:,i) -= feld_oben;
end
flipud(feld.')  % druck-plot gegen (x,y)
% Bedeutung feld-Werte: -1=leer, 0=besetzt, andere:
% Cluster Indizes

% Plot
figure();axis([0 L+1 0 L+1]);hold on;
% besetzt/leer:
for y=1:L
  plot(1:L,y,'*r');
end
% Linien
for x=1:L-1, for y=1:L
    if feld(x,y) >= 0 & feld(x+1,y) >= 0, plot([x x+1],[y y],'-r'); end
end,end
for x=1:L, for y=1:L-1
    if feld(x,y) >= 0 & feld(x,y+1) >= 0, plot([x x],[y y+1],'-r'); end
end,end
axis off;

pause

disp('Ergebnis, Baumsuche:');
[feld] = baum_analyse(feld);
flipud(feld.')
disp('Ergebnis, Hoshen-Kopelman:');
[feld] = hoshen_kopelman(feld);
flipud(feld.')

%  bondperkolation - alle nachbarn immer verbunden, aber nur
%  einige der verbindungen sind aktiv

%  dann immer fallunterscheidung zwischen diesen faellen
%  die matrix hat demnach auch nur (Lx-1)x(Ly-1) als dimension
%  von jedem punkt aus werden nur die rechten bzw. unteren nachbarn ueberprueft
%  hab mal versucht, den code in baum_analyse ab zeile 58 so aufzubauen; der aufruf
%  in dieser datei hier fehlt noch; und in der anderen datei wird noch einiges falsch sein ;)