CFLAGS=-ggdb -g -Wall -O0 -std=gnu99

all:		punkt_perk

punkt_perk:	punkt_perk.o cluster_analyse.o R250.o

clean:
	-rm -f punkt_perk punkt_perk.o cluster_analyse.o R250.o *~
	-rm -rf ../tmp
	@echo "clean-up done"

run: 		all
	./punkt_perk > ../tmp/plot.dat
	make plot
plot:		all
	./plot.gp 2>&1 | grep -A 6 "Final set of parameters"

.PHONY: 	run clean all plot



