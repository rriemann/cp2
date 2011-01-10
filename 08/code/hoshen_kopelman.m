function [cluster_feld] = hoshen_kopelman(bond_feld)
% Clusteranalyse a la Hoshen Kopelman 
[Lx,Ly] = size(bond_feld);
cluster_feld = bond_feld;

label = zeros(Lx*Ly+1,1); % Arbeitsliste
LEER = Lx*Ly+1;           % groesser als der maximale Clusterindex
label(LEER) = LEER;       % auf sich selbst zeigend
neu = 1;

for x = Lx:-1:1
  for y = Ly:-1:1
    if bond_feld(x,y) == 0 % keine Verbindung nach unten/rechts
      cluster_feld(x,y) = LEER;
    else % es gibt Verbindungen
      rechts = LEER;
      if bond_feld(x,y) < -1
        rechts = cluster_feld(x,y+1);
      end
      unten = LEER;
      if rem(bond_feld(x,y),2) == -1
        unten = cluster_feld(x+1,y);
        while label(unten) < unten
          unten = label(unten);
        end
      end
      if rechts == LEER && unten == LEER % neuen Index vergeben
        cluster_feld(x,y) = neu;
        label(neu) = neu; % auf sich selbst zeigend
        neu += 1;
      else
        v = sort([unten rechts]);
        cluster_feld(x,y) = v(1);
        if v(2) < LEER
          label(v(2)) = v(1);
        end
      end
    end
  end
end

%  alle auf gute label setzen, Leerstellen wieder -1 ::
for y=1:Ly
  for x=1:Lx
    n = cluster_feld(x,y);
    while label(n) < n  % gutes label finden
      n = label(n);
    end
    if n == LEER
      n = 0; % Leerstellen sind 0
    end
    cluster_feld(x,y) = n;
  end
end
