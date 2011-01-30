
#include <string>
#include <iostream>
#include <TRandom3.h>
#include <stdlib.h>
#include <assert.h>
#include "torus_hopping.h"
#include <math.h>

using std::vector;
using std::string;
using std::cout;
using std::endl;

typedef int *field;
typedef int spin;
const spin up = 1;
const spin down = 0;

// arguments: L (lenght), D (dimension), i (r = 0 (random spin) or anything else (all spin up)
int main(int argc, char *argv[]) {
    // argv[0] is app name

    assert(argc == 4);
    const int lenght = atoi(argv[1]);
    const int dimension = atoi(argv[2]); // read dimension from first cmd option
    const int rand_mode = atoi(argv[3]); // read random mode
    const int volume = pow(lenght,dimension);
    TRandom3 ran(0);

    // build field L^D with lengh L and dimension D
    field feld = (spin*)malloc(volume*sizeof(spin));

    for(int i = 0; i < volume; ++i) {
        feld[i] = (rand_mode == 0) ? (ran.Uniform() > 0.5) : 1;
    }

    // get hopping array
    int **hop = (int**)malloc(volume*2*dimension*sizeof(spin));
    torus_hopping(&hop[0][0], lenght, dimension);
}

