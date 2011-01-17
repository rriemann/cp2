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
int perkolation(field feld, int L);
double P(field feld, int L, int perk_cluster);
int dsc_sorter(const void *i1, const void *i2);
int* cluster_sizes(int *array, int size);

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


    printf("#L S P_inf\n");
    for (L = 40; L <= 100; L += 20){ // stride gross -> hier egal, arbeiten nicht mit vektoren
        double P_inf_sum = 0;
        double S_sum = 0;
        for (i = 0; i < 100; i++){

            initR250(seed*i);    /* Initialisierung von R250 */
//             double norm = 1/(L*L);
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

            /* Cluster identifizieren: Hoshen&Kopelman */
            hoshen_kopelman(feld,L);
            
//             perkolierender cluster?
            int perk_cluster = perkolation(feld, L);
	    
            if ( perk_cluster != -1) {
                P_inf_sum += P(feld, L, perk_cluster);
            } else {
                P_inf_sum += -1;
            }
//             memcpy(feld1[0],feld[0],L*L*sizeof(int));
            int L2 = L*L;
            int *ns = cluster_sizes(feld[0],L2);
            int s2 = 0;
            int s1 = 0;
            for(int i = 0; i < L2; ++i) {
                if (ns[i] == 0) break;
                s2 += ns[i]*ns[i];
                s1 += ns[i];
            }
            if (perk_cluster != -1) {
              s2 -= perk_cluster*perk_cluster;
              s1 -= perk_cluster;
            }
            S_sum += (double) s1/s2;
            free(ns);
        }
    printf("%d %f %f\n", L, S_sum/100, P_inf_sum/100);
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
    return NULL;
}

int perkolation(field feld, int L){
    int j, k, clusternummer = -1;
    for (j = 0; j < L; j++) {
	for (k = 0; k < L; k++) {
	    if ( feld[j][0] == feld[k][L-1] && feld[j][0] != -1 ) {
	        clusternummer = feld[j][0];
	    }
	    if ( feld[0][j] == feld[L-1][k]  && feld[0][j] != -1 ) {
	        clusternummer = feld[0][j];
	    }
	}
    }
    return clusternummer;
}

double P(field feld, int L, int perk_cluster) {
    int count_active = 0;
    int count_perk = 0;
    int j, k;
    
    for (j = 0; j < L; j++) {
        for (k = 0; k < L; k++) {
            if ( feld[j][k] == perk_cluster ) {
                count_perk++;
            count_active++;
            }
            else if ( feld[j][k] != -1) {
                count_active++;
            }
        }
    }
    return (double) count_perk/count_active;
}

int dsc_sorter(const void *i1, const void *i2) {
    return *(int *)i2 - *(int *)i1; /* absteigend sortiert */
}

int* cluster_sizes(int *array, int size) {
    int *n;
    n = malloc(size*sizeof(int));
    for (int i = 0; i < size; ++i) {
        n[i] = 0;
    }
    qsort(array, size, sizeof(array), dsc_sorter);
    int current_cluster = array[0];
    int j = 1;
    n[j] = 1;
    for (int i = 2; i < size; ++i) {
        if (array[i] == -1) {
            break;
        } else if (array[i] != current_cluster) {
            ++j;
            current_cluster = array[i];
        }
        n[j] += 1;
    }
    qsort(n, size, sizeof(int), dsc_sorter);
    return n;
}
