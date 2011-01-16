# CXXFLAGS=`root-config --cflags`
# LDLIBS=`root-config --libs` -lMinuit2

CFLAGS=-ggdb -g -Wall

all:		punkt_perk

punkt_perk:	punkt_perk.o cluster_analyse.o R250.o

clean:
	-rm -f punkt_perk.out punkt_perk.o cluster_analyse.o R250.o *~
	@echo "clean-up done"

run: 		main
	./main

.PHONY: 	run clean all



