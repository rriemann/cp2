function [feldr] = baum_analyse(feld)
% Clusteranalyse mit Baumsuche
feldr=feld;
[Lx,Ly]=size(feld);

liste=zeros(Lx*Ly,2); % Arbeitsliste fuer Clustersuche
cluster=0;

for ya=1:Ly
for xa=1:Lx
   if feldr(xa,ya)==0
       cluster=cluster+1; % neuer Index vergeben
       feldr(xa,ya)=cluster;
       liste(1,:)=[xa ya];
       n=1; % letzter benutzter Listenplatz
       i=0;
       while i < n
           i=i+1;
           x=liste(i,1);y=liste(i,2);
           % rechten Nachbarn pruefen
           if x < Lx,
               if feldr(x+1,y)==0
                   feldr(x+1,y)=cluster;
                   n=n+1;
                   liste(n,:)=[x+1 y];
               end
           end
           % linken Nachbarn pruefen
           if x > 1
               if feldr(x-1,y)==0
                   feldr(x-1,y)=cluster;
                   n=n+1;
                   liste(n,:)=[x-1 y];
               end
           end
           % oberen Nachbarn pruefen
           if y < Ly
               if feldr(x,y+1)==0
                   feldr(x,y+1)=cluster;
                   n=n+1;
                   liste(n,:)=[x y+1];
               end
           end
           % unteren Nachbarn pruefen
           if y > 1
               if feldr(x,y-1)==0
                   feldr(x,y-1)=cluster;
                   n=n+1;
                   liste(n,:)=[x y-1];
               end
           end
       end % while loop: Cluster komplett
%       fprintf('\n Cluster % i aus %i  Punkten \n',cluster,n)
   end
end
end

%  bondperkolation - alle nachbarn immer verbunden, aber nur
%  einige der verbindungen sind aktiv