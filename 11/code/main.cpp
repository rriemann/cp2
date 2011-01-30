
#include <string>
#include <iostream>
#include <TRandom3.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

using std::vector;
using std::string;
using std::cout;
using std::endl;

typedef int *field;
typedef int spin;
const spin up = 1;
const spin down = 0;

void torus_hopping(int* hop, int length, int dimension, int volume);

// arguments: L (lenght), D (dimension), i (r = 0 (random spin) or anything else (all spin up)
int main(int argc, char *argv[]) {
    // argv[0] is app name

    assert(argc == 4);
    const int length = atoi(argv[1]);
    const int dimension = atoi(argv[2]); // read dimension from first cmd option
    const int rand_mode = atoi(argv[3]); // read random mode
    const int volume = pow(length,dimension);
    TRandom3 ran(0);

    // build field L^D with lengh L and dimension D
    field feld = (spin*)malloc(volume*sizeof(spin));

    for (int i = 0; i < volume; ++i) {
        feld[i] = (rand_mode == 0) ? (ran.Uniform() > 0.5) : 1;
    }

    // get hopping array
    int *hop = (int*)malloc(volume*2*dimension*sizeof(spin));


    torus_hopping(hop, length, dimension, volume);

    free(hop);
    free(feld);

    return 0;
}


void torus_hopping(int *hop, int length, int dimension, int volume) {
    int Lmu, n_x, r_x;
    int mu, x_mu, x_muP, x_muM;

    for (n_x=0; n_x < volume ; n_x++) {
        Lmu = volume;
        r_x=n_x;
        for (mu=dimension-1; mu >= 0; mu--) {
            Lmu=Lmu/length;                     /* = L^mu */
            x_mu=r_x/Lmu;                  /* mu'te Komponente rausholen */
            r_x=r_x-x_mu*Lmu;              /* Restindex aus x_0 .. x_(mu-1) */

            x_muP=(x_mu+1)%length;              /* vorwaerts, modulo wg Ueberlauf */
            hop[2*dimension*n_x + mu]   = n_x + (x_muP-x_mu)*Lmu;

            x_muM=(x_mu-1+length)%length;            /* rueckwaerts, '+L' fuer korrekten Ueberlauf */
            hop[2*dimension*n_x+(mu+dimension)] = n_x + (x_muM-x_mu)*Lmu;
        }
    }
}

