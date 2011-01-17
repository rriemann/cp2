# CXXFLAGS=`root-config --cflags`
# LDLIBS=`root-config --libs` -lMinuit2

CFLAGS=-ggdb -g -Wall -O0 -std=gnu99

all:		punkt_perk

punkt_perk:	punkt_perk.o cluster_analyse.o R250.o

clean:
	-rm -f punkt_perk punkt_perk.o cluster_analyse.o R250.o *~
	@echo "clean-up done"

run: 		all
	./punkt_perk

.PHONY: 	run clean all



