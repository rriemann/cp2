CXXFLAGS=`root-config --cflags` -Wall -g
LDLIBS=`root-config --libs`

all:	main

main: 	main.o

run: 	main
	./main

clean:
	rm -f main main.o

.PHONY:	run clean