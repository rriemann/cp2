function [bond_feld] = baum_analyse(bond_feld)
% Clusteranalyse mit Baumsuche
%  feldr=feld;
[Lx,Ly]=size(bond_feld);

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

%  bondperkolation
bond_liste = zeros(Lx*Ly,2);
cluster=0;

for ya=1:Ly
for xa=1:Lx
   if bond_feld(xa,ya) <= 0
       cluster=cluster+1; % neuer Index vergeben
%         bond_feld(xa,ya) = cluster;
       bond_liste(1,:)=[xa ya];
       n=1; % letzter benutzter Listenplatz
       i=0;
       while i < n
           i=i+1;
           x=bond_liste(i,1);y=bond_liste(i,2);
           % rechten Nachbarn pruefen
           if x < Lx,
%  	      bond_feld(x,y)
               if ((bond_feld(x,y) == -2 || bond_feld(x,y) == -3) && bond_feld(x+1,y) <= 0)
                   bond_feld(x+1,y)=cluster;
                   n=n+1;
                   bond_liste(n,:)=[x+1 y];
               end
           end
           % linken Nachbarn pruefen
           if x > 1
               if ((bond_feld(x-1,y) == -2 || bond_feld(x-1,y) == -3) && bond_feld(x,y) <= 0)
                   bond_feld(x-1,y)=cluster;
                   n=n+1;
                   bond_liste(n,:)=[x-1 y];
               end
           end
           % oberen Nachbarn pruefen
           if y < Ly
               if ((bond_feld(x,y) == -1 || bond_feld(x,y) == -3) && bond_feld(x,y+1) <= 0)
                   bond_feld(x,y+1)=cluster;
                   n=n+1;
                   bond_liste(n,:)=[x y+1];
               end
           end
           % unteren Nachbarn pruefen
           if y > 1
               if ((bond_feld(x,y-1) == -1 || bond_feld(x,y-1) == -3) && bond_feld(x,y) <= 0)
                   bond_feld(x,y-1)=cluster;
                   n=n+1;
                   bond_liste(n,:)=[x y-1];
               end
           end
       end % while loop: Cluster komplett
%       fprintf('\n Cluster % i aus %i  Punkten \n',cluster,n)
       bond_feld(xa,ya) = cluster;
   end
end
end