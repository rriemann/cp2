
#include <string>
#include <iostream>
#include <iomanip>
#include <TRandom3.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <omp.h>

using std::vector;
using std::string;
using std::cout;
using std::endl;

typedef int *field;
typedef int spin;
const spin up = 1;
const spin down = -1;

double magnetization(int feld[], int length);
void torus_hopping(int* hop, int length, int dimension, int volume);
double energy(int feld[], int** neighbours, int volume, double coupling, double b, int dimension2);
void sweep(field feld, TRandom3 *ran, int** neighbours, int dimension2, double beta, int volume, double b);

// arguments: L (lenght), D (dimension), i (r = 0 (random spin) or anything else (all spin up), b B field, beta
int main(int argc, char *argv[]) {
    // argv[0] is app name

    const double coupling = 0.5;
    assert(argc == 6);
    const int length = atoi(argv[1]);
    const int dimension = atoi(argv[2]); // read dimension from first cmd option
    const int dimension2 = 2*dimension;
    const int rand_mode = atoi(argv[3]); // read random mode
    const double b = atof(argv[4]);
    const double beta = atof(argv[5]);
    const int volume = pow(length,dimension);
    TRandom3 *ran = new TRandom3(0);
    double magn[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    double ener[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    // build field L^D with lengh L and dimension D
    field feld = (spin*)malloc(volume*sizeof(spin));

    if (rand_mode == 0) {
        for (int i = 0; i < volume; ++i) {
            feld[i] = 2*(ran->Uniform() > 0.5) - 1;
        }
    } else {
        #pragma omp parallel for
        for (int i = 0; i < volume; ++i) {
            feld[i] = up;
        }
    }

    // get hopping array
    int **neighbours = (int**)malloc(volume*sizeof(int*));
    neighbours[0] = (int*)malloc(volume*dimension2*sizeof(int));
    #pragma omp parallel for
    for(int i = 1; i < volume; ++i) {
        neighbours[i] = neighbours[0] + i*dimension2;
    }

    torus_hopping(neighbours[0], length, dimension, volume);

    cout << std::setprecision(5) << std::fixed;

    double mean_m=0, mean_e=0, mean_m2=0, mean_e2=0;
    for (int i = 0; i < 10; ++i) {
        for(int j = 0; j < 1e4; ++j) {
            magn[i] += magnetization(feld, volume);
            ener[i] += energy(feld, neighbours, volume, coupling, b, dimension2);
            sweep(feld,ran,neighbours,dimension2,beta,volume,b);
        }
        magn[i] *= 1e-4;
        ener[i] *= 1e-4;
        cout << "magnetization: " << magn[i] << endl;
        cout << "energy: " << ener[i] << endl;
        mean_m2 += magn[i]*magn[i];
        mean_m += magn[i];
        mean_e2 += ener[i]*ener[i];
        mean_e += ener[i];
    }

    cout << "σ magnetization: " << sqrt(mean_m2*0.1 - mean_m*mean_m*0.01) << endl;
    cout << "σ energy: " << sqrt(mean_e2*0.1 - mean_e*mean_e*0.01) << endl;

    free(neighbours);
    free(feld);

    return 0;
}

void sweep(field feld, TRandom3 *ran, int **neighbours, int dimension2, double beta, int volume, double b) {
    double bb, bbb;
    for(int i = 0; i < volume; ++i) {
        bb = 0;
        #pragma omp parallel for reduction(+:bb) private(bbb)
        for(int j = 0; j < dimension2; ++j) {
            bb += feld[neighbours[i][j]];
        }
        bbb = beta*(bb+b);
        feld[i] = 2*(ran->Uniform() < exp(bbb)/(exp(bbb)+exp(-bbb)))-1;
    }
}

double magnetization(field feld, int volume) {
    int sum = 0;
    #pragma omp parallel for reduction(+:sum)
    for(int i = 0; i < volume; ++i) {
        sum += feld[i];
    }
    return sum*1./volume;
}

double energy(field feld, int **neighbours, int volume, double coupling, double b, int dimension2) {
    int energy_c = 0;
    int energy_b = 0;
    int energy_n = 0;
    #pragma omp parallel for shared(neighbours,feld) private(energy_n) reduction(+:energy_c,energy_b)
    for(int i = 0; i < volume; ++i) {
        energy_n = 0;
        for(int j = 0; j < dimension2; ++j) {
            energy_n += feld[neighbours[i][j]];
        }
        energy_c += energy_n*feld[i];
        energy_b += feld[i];
    }
    return -(energy_c*coupling+energy_b*b)/(double)volume;
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

