#!/usr/bin/env octave
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
L=10;  % Gittergroesse L*L
p=0.4;  % Besetzungswahrscheinlichkeit
rand('state',0); % Standard initialisierung der Zufallszahlen

disp('Bondbesetzung:');
%  nach oben und rechts: wert = -3, wenn nur rechts: wert = -2, nur unten: -1; passiv: 0
function feld = feld_generator(L,p)
  feld_rechts = (rand(L,L-1) < p); % 1 = verbindung nach rechts
  feld_unten = (rand(L-1,L) < p); % 1 = verbindung nach unten
  feld = zeros(L,L);
  for i=1:L-1
    feld(:,i) -= 2*feld_rechts(:,i);
    feld(i,:) -= feld_unten(i,:);
  end
end
feld = feld_generator(L,p)

% Plot
figure();axis([0 L+1 0 L+1]);hold on;
% Plot von Punkten und Linien
for x=1:L
  for y=1:L
    plot(x,y,'*r');
    if rem(feld(x,y),2) == -1 % verbindung nach unten
      plot([y y],[L+1-x L-x],'-b');
    end
    if feld(x,y) < -1 % verbindung nach rechts
      plot([y y+1],[L+1-x L+1-x],'-b');
    end
  end
end
%  plot([1 1],[L+1-1 L+1-1-1],'-b');
axis off;

print('../tmp/bonds.png');

%  pause

disp('Ergebnis, Baumsuche:');
[baum_feld] = baum_analyse(feld);
baum_feld

disp('Ergebnis, Hoshen-Kopelman:');
[hs_feld] = hoshen_kopelman(feld);
hs_feld


% Zeitenmessung
feld = feld_generator(1000,0.5);
tic; baum_analyse(feld); toc;    % Elapsed time is 171 seconds.
tic; hoshen_kopelman(feld); toc; % Elapsed time is 117 seconds.


% Aufgabe 8.2
function [C] = clustersort(feld)
  feld = sort(reshape(feld,numel(feld),1));
  L = size(feld);
  cluster = feld(1);
  n = zeros(round(L(1)/2),1);
  j = 1;
  n(j) = 1;
  for i = 2:L
      if cluster == feld(i);
          % Addiere Feld zu Clustergroesse
          n(j) = n(j)+1;
      else
          % neuer Cluster
          cluster = feld(i);
          j = j+1;
          n(j) = 1;
      end
  end
  C = max(n); % Finde maximalen Cluster
end