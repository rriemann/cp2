CXXFLAGS=`root-config --cflags` -Wall -fopenmp -g
LDLIBS=`root-config --libs` -lgomp

all:	main

main: 	main.o

#  L (lenght), D (dimension), i (r = 0 (random spin) or anything else (all spin up), b B field, beta
# run: 	main
# 	./main
run11:	main
	./main 4  1 0 0.2 0.5 0
run12:	main
	./main 20 1 0 0.2 0.5 0
run13:	main
	./main 4  2 0 0.2 0.4 0
run14:	main
	./main 10 2 0 0.2 0.4 0

runc1:	main
	./main 10 2 0 0.1 0.4 1 0.02 10000 > output_c1.txt

runc2:	main
	./main 10 2 0 0.15 0.5 1 0.01 1000 > output_c2.txt

plot:	runc1 runc2
	gnuplot plot.gp

clean:
	rm -f main main.o

.PHONY:	run clean run11 run12 run13 run14 runc1 runc2 plot