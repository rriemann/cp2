/*    file punkt_perk.c
      main zu Punktperkolation */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "R250.h"
#include "cluster_analyse.h"

typedef int **field;
void print_field(field feld, int L);
field malloc_field(int L);
int* ns(field feld, int L);

int main(void){

    field feld1, feld; /* Status der Gitterpunkte:
			    feld = -1 : unbesetzt
			    =  0 : besetzt
			    >  0 : Clusternummer
			    */
    int *fp;

    double p  = 0.5927; /* Aktivierungswahrscheinlichkeit */

    int seed = 137; /* Seed fuer R250 */
    int L;
    int i;


    for (i = 0; i < 100; i++){
        for (L = 40; L <= 100; L += 20){ // stride gross -> hier egal, arbeiten nicht mit vektoren
            initR250(seed);    /* Initialisierung von R250 */
            double norm = 1/(L*L);
            /* Allokation der Felder */
            feld=malloc_field(L);

            feld1=malloc_field(L);

            /* Belegung des Feldes mit Zufallseintraegen*/
            fp =feld[0];
            for (int x = 0; x < L*L; x++){
            if (R250() < p) *fp = 0;
            else            *fp = -1;
            fp++;
            }
            memcpy(feld1[0],feld[0],L*L*sizeof(int)); /* Kopie fuer Vergleich der Algorithmen */


            // 	printf("\n Punktbesetzung:");
            // 	print_field(feld,L);

            /* Cluster identifizieren: Baumsuche*/
            baum_analyse(feld,L);
            // 	printf("\n Ergebnis Baumsuche:");
            // 	print_field(feld,L);


            /* Cluster identifizieren: Hoshen&Kopelman */
            hoshen_kopelman(feld1,L);
            // 	printf("\n Ergebnis Hoshen Kopelmann:");
            // 	print_field(feld1,L);

            double S;				// hier kommt die S-berechnung rein.
        }
    }

    return 0;
}     /* main */

field malloc_field(int L)
{
    field feld;
    feld=malloc(L*sizeof(int*));
    feld[0]=malloc(L*L*sizeof(int));
    if (feld[0]==NULL ) {
        fprintf(stderr,"Not enough memory for allocating field\n");
        exit(1);
    }
    for (int x = 1; x<L;x++)
        feld[x]=feld[0]+L*x;
    return feld;
}

/*Ausgabe des Feldes auf dem Bildschirm */
void print_field(field feld, int L)
{
    int x,y;
    for (y = L-1; y >= 0; y--){
	printf("\n");
	for (x = 0; x < L; x++)
	    printf("%4i",feld[y][x]);     /* Clusterzerlegung ausdrucken */
    }
    printf("\n");
}

int* ns(field feld, int L) {
}


// #undef  Lp
