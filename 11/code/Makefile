CXXFLAGS=`root-config --cflags` -Wall -g -fopenmp
LDLIBS=`root-config --libs` -lgomp

all:	main

main: 	main.o

run: 	main
	./main

clean:
	rm -f main main.o

.PHONY:	run clean