% file punkt_perk.m
% Hauptprogramm zur Perkolation

L=12;  % Gittergroesse L*L
p=0.5;  % Besetzungswahrscheinlichkeit
rand('state',0); % Standard initialisierung der Zufallszahlen

disp('Punktbesetzung:');
feld=-(rand(L,L) > p);
flipud(feld.')  % druck-plot gegen (x,y)
% Bedeutung feld-Werte: -1=leer, 0=besetzt, andere: 
% Cluster Indizes

% Plot
figure();axis([0 L+1 0 L+1]);hold on;
% besetzt/leer:
for x=1:L, for y=1:L
   if feld(x,y) >= 0, plot(x,y,'*r'); else, plot(x,y,'.b'); end        
end,end
% Linien zwischen besetzten Nachbarn
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
