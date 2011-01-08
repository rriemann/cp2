# Makefile um  punkt_perk.c baumanalyse.c  zu compilieren
# Aufruf:  make <target> 
# <target> = clean, all, m_quick.out, m_quick.o, quick.o

all:	punkt_perk.out  punkt_perk.o cluster_analyse.o R250.o
.PHONY : all

clean:
	-rm -f punkt_perk.out punkt_perk.o cluster_analyse.o R250.o *~
	@echo "clean-up done"
.PHONY : clean

punkt_perk.out: punkt_perk.o cluster_analyse.o R250.o
	gcc -o punkt_perk.out punkt_perk.o cluster_analyse.o R250.o

punkt_perk.o: punkt_perk.c 
	gcc -c -Wall punkt_perk.c

cluster_analyse.o: cluster_analyse.c 
	gcc -c -Wall cluster_analyse.c

R250.o: R250.c 
	gcc -c -Wall R250.c


