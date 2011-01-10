function [cluster_feld] = baum_analyse(bond_feld)
% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
% Clusteranalyse mit Baumsuche
cluster_feld = bond_feld;
[Lx,Ly] = size(bond_feld);

%  bondperkolation
bond_liste = zeros(Lx*Ly,2);
cluster = 0;

for ya = 1:Ly
  for xa = 1:Lx
    if cluster_feld(xa,ya) < 0 % Verbindungen existieren
      cluster += 1; % neuer Index vergeben
      bond_feldr(xa,ya) = cluster;
      bond_liste(1,:) = [xa ya];
      n = 1; % letzter benutzter Listenplatz
      i = 0;
      while i < n
        i += 1;
        x = bond_liste(i,1);
        y = bond_liste(i,2);
        % rechten Nachbarn pruefen (Matrix-System)
        if y < Ly
          if bond_feld(x,y) < -1
            cluster_feld(x,y+1) = cluster;
            n=n+1;
            bond_liste(n,:) = [x y+1];
          end
        end
        % linken Nachbarn pruefen (Matrix-System)
        if y > 1
          if bond_feld(x,y-1) < -1
            cluster_feld(x,y-1) = cluster;
            n=n+1;
            bond_liste(n,:)=[x y-1];
          end
        end
        % oberen Nachbarn pruefen (Matrix-System)
        if x > 1
          if rem(bond_feld(x-1,y),2) == -1
            cluster_feld(x-1,y) = cluster;
            n=n+1;
            bond_liste(n,:)=[x-1 y];
          end
        end
        % unteren Nachbarn pruefen (Matrix-System)
        if x < Lx
          if rem(bond_feld(x,y),2) == -1
            cluster_feld(x+1,y) = cluster;
            n=n+1;
            bond_liste(n,:)=[x+1 y];
          end
        end
      end
    end
  end
end

%  liste=zeros(Lx*Ly,2); % Arbeitsliste fuer Clustersuche
%  cluster=0;
%
%  for ya=1:Ly
%  for xa=1:Lx
%     if feldr(xa,ya)==0
%         cluster=cluster+1; % neuer Index vergeben
%         feldr(xa,ya)=cluster;
%         liste(1,:)=[xa ya];
%         n=1; % letzter benutzter Listenplatz
%         i=0;
%         while i < n
%             i=i+1;
%             x=liste(i,1);y=liste(i,2);
%             % rechten Nachbarn pruefen
%             if x < Lx,
%                 if feldr(x+1,y)==0
%                     feldr(x+1,y)=cluster;
%                     n=n+1;
%                     liste(n,:)=[x+1 y];
%                 end
%             end
%             % linken Nachbarn pruefen
%             if x > 1
%                 if feldr(x-1,y)==0
%                     feldr(x-1,y)=cluster;
%                     n=n+1;
%                     liste(n,:)=[x-1 y];
%                 end
%             end
%             % oberen Nachbarn pruefen
%             if y < Ly
%                 if feldr(x,y+1)==0
%                     feldr(x,y+1)=cluster;
%                     n=n+1;
%                     liste(n,:)=[x y+1];
%                 end
%             end
%             % unteren Nachbarn pruefen
%             if y > 1
%                 if feldr(x,y-1)==0
%                     feldr(x,y-1)=cluster;
%                     n=n+1;
%                     liste(n,:)=[x y-1];
%                 end
%             end
%         end % while loop: Cluster komplett
%  %       fprintf('\n Cluster % i aus %i  Punkten \n',cluster,n)
%     end
%  end
%  end