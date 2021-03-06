function [feldr] = hoshen_kopelman(feld)
% Clusteranalyse a la Hoshen Kopelman 
feldr=feld; % return Variable
[Lx,Ly]=size(feld);

label=zeros(Lx*Ly+1,1); % Arbeitsliste
LEER=Lx*Ly+1;           % groesser als der maximale Clusterindex
label(LEER)=LEER;       % auf sich selbst zeigend
neu=1;

for y=1:Ly
for x=1:Lx
    if feldr(x,y) == -1 
        feldr(x,y)=LEER; % leerer Punkt, umbenannt
    else                 % besetzter Punkt::
        links=LEER;
        if x > 1, links=feldr(x-1,y); end
        unten=LEER;
        if y > 1, unten=feldr(x,y-1);
            while label(unten) < unten, unten=label(unten);end
        end
        if links==LEER && unten==LEER % neuen Index vergeben
            feldr(x,y)=neu;
            label(neu)=neu;          % auf sich selbst zeigend
            neu=neu+1;
        elseif links < unten
            feldr(x,y)=links;
            if unten < LEER, label(unten)=links; end % Cluster verbinden
        else   % unten <= links
            feldr(x,y)=unten;
            if links < LEER, label(links)=unten; end % Cluster verbinden
        end
    end
end % loop x
end % loop y
% vorlaeufige Nummerierung fertig

% alle auf gute label setzen, Leerstellen wieder -1 ::
for y=1:Ly
for x=1:Lx
    n=feldr(x,y);
    while label(n) < n, n=label(n);end % gutes label finden
    feldr(x,y)=n;
    if n == LEER, feldr(x,y)=-1;end % Leerstellen -> -1
end
end
