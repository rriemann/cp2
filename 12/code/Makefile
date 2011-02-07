CXXFLAGS=`root-config --cflags` -Wall -fopenmp -g
LDLIBS=`root-config --libs` -lgomp

all:	main

main: 	main.o

#  L (lenght), D (dimension), i (r = 0 (random spin) or anything else (all spin up), b B field, beta
# run: 	main
# 	./main
run11:	main
	./main 4  1 0 0.2 0.5
run12:	main
	./main 20 1 0 0.2 0.5
run13:	main
	./main 4  2 0 0.2 0.4
run14:	main
	./main 10 2 0 0.2 0.4

clean:
	rm -f main main.o

.PHONY:	run clean