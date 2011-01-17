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
int perkolation(field feld, int L);
double P(field feld, int L, int perk_cluster);
int dsc_sorter(const void *i1, const void *i2);
int* cluster_sizes(int *array, int size, int perk_cluster);

int main(void)
{

    field feld; /* Status der Gitterpunkte:
                feld = -1 : unbesetzt
                =  0 : besetzt
                >  0 : Clusternummer
                */
    int *fp;

    double p = 0.5927; /* Aktivierungswahrscheinlichkeit */
    int repititions = 10000;

    int seed = 137; /* Seed fuer R250 */

    printf("#L S P_inf\n");
    for(int L = 40; L <= 100; L += 20) {
        double P_inf_sum = 0;
        double S_sum = 0;
        int L2 = L * L;
        for(int i = 0; i < repititions; i++) {
            initR250(seed + i + L); /* Initialisierung von R250 */
            /* Allokation der Felder */
            feld = malloc_field(L);

            /* Belegung des Feldes mit Zufallseintraegen*/
            fp = feld[0];
            for(int x = 0; x < L * L; x++) {
                if(R250() < p) *fp = 0;
                else            *fp = -1;
                fp++;
            }

            /* Cluster identifizieren: Hoshen&Kopelman */
//             print_field(feld,L);
            hoshen_kopelman(feld, L);

//             perkolierender cluster?
            int perk_cluster = perkolation(feld, L);
//             printf("perk_cluster: %d\n\n",perk_cluster);
//             exit(0);
            if(perk_cluster != 0) {
                P_inf_sum += P(feld, L, perk_cluster);
            }

            int *ns = cluster_sizes(feld[0], L2, perk_cluster);
            int s2 = 0;
            int s1 = 0;
            for(int i = 0; i < L2; ++i) {
                if(ns[i] == 0) break;
                s2 += ns[i] * ns[i];
                s1 += ns[i];
            }
            S_sum += (double) s2 / s1;
            free(ns);
        }
        printf("%d %f %f\n", L, S_sum / repititions, P_inf_sum / repititions);
    }
    return 0;
}     /* main */

field malloc_field(int L)
{
    field feld;
    feld = malloc(L * sizeof(int*));
    feld[0] = malloc(L * L * sizeof(int));
    if(feld[0] == NULL) {
        fprintf(stderr, "Not enough memory for allocating field\n");
        exit(1);
    }
    for(int x = 1; x < L; x++)
        feld[x] = feld[0] + L * x;
    return feld;
}

/*Ausgabe des Feldes auf dem Bildschirm */
void print_field(field feld, int L)
{
    int x, y;
    for(y = L - 1; y >= 0; y--) {
        printf("\n");
        for(x = 0; x < L; x++)
            printf("%4i", feld[y][x]);    /* Clusterzerlegung ausdrucken */
    }
    printf("\n");
}

int perkolation(field feld, int L)
{
//     print_field(feld,L);
    int clusternummer = 0;
    for(int j = 0; j < L; j++) {
        for(int k = 0; k < L; k++) {
            if(feld[j][0] == feld[k][L-1] && feld[j][0] != -1) {
                clusternummer = feld[j][0];
            }
            if(feld[0][j] == feld[L-1][k] && feld[0][j] != -1) {
                clusternummer = feld[0][j];
            }
//      printf("%d %d %d %d %d %d\n", j, k, feld[0][j], feld[k][L-1], feld[j][0], feld[L-1][k]);
        }
    }
    return clusternummer;
}

double P(field feld, int L, int perk_cluster)
{
    int count_active = 0;
    int count_perk = 0;
    int j, k;

    for(j = 0; j < L; j++) {
        for(k = 0; k < L; k++) {
            if(feld[j][k] == perk_cluster) {
                count_perk++;
                count_active++;
            } else if(feld[j][k] != -1) {
                count_active++;
            }
        }
    }
    return (double) count_perk / count_active;
}

int dsc_sorter(const void *i1, const void *i2)
{
    return *(int *)i2 - *(int *)i1; /* absteigend sortiert */
}

int* cluster_sizes(int *array, int size, int perk_cluster)
{
    int *n;
    n = malloc(size * sizeof(*n));
    if(n == NULL) {
        fprintf(stderr, "Not enough memory for allocating n in cluster_sizes\n");
        exit(1);
    }
    for(int i = 0; i < size; ++i) {
        n[i] = 0;
    }
    qsort(array, size, sizeof(*array), dsc_sorter);
    int current_cluster = 0;
    int j = -1;
    for(int i = 0; i < size; ++i) {
        if(array[i] == -1) {
            break;
        } else if(array[i] == current_cluster) {
            n[j] += 1;
        } else if(array[i] != perk_cluster) {
            ++j;
            current_cluster = array[i];
            n[j] += 1;
        }
    }
    qsort(n, size, sizeof(*n), dsc_sorter);
//     for(int i = 0; i < size; ++i) {
//         printf("%d\n",n[i]);
//     }
//     exit(0);
    return n;
}
