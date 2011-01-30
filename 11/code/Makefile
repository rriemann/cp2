CXXFLAGS=`root-config --cflags`
LDLIBS=`root-config --libs`

all:	main

main: 	main.o torus_hopping.o

run: 	main
	./main

clean:
	rm -f main main.o torus_hopping.o

.PHONY:	run clean