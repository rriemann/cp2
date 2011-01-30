CXXFLAGS=`root-config --cflags`
LDLIBS=`root-config --libs` -lMinuit2

all:	main

main: 	main.o torus_hopping.o

run: 	main
	./main

clean:
	rm -f main main.o

.PHONY:	run clean