/*    file cluster_analyse.c
      Punkt-Perkolation */

#include <stdlib.h>
#include "cluster_analyse.h"

/*      Cluster-Analyse a la Hoshen Kopelman */

void hoshen_kopelman(int **feld, int L)
{

    int x, y ;                      /* aktueller Punkt, Feldindex = x+y*L */
    int neu;                        /* neue Clusternummer */
    int links, unten;               /* vorlaeufige Label der Nachbarn */
    int LEER;                       /* Label fuer Leerstellen */
    int n;

    int *label;

    /* Arbeitslist fuer Clustersuche dynamisch alloziert: */
    /* vorlaeufige -> endgueltige Num. */
    label = (int *) malloc((L * L + 2) * sizeof(int));

    LEER = L * L + 1;
    label[LEER] = LEER;
    neu = 1;

    for(y = 0; y < L; y++) for(x = 0; x < L; x++) {
            if(feld[y][x] == -1) {        /* leerer Punkt */
                feld[y][x] = LEER;
            } else {                         /* besetzter Punkt */

                /* linker Nachbar */
                if(x > 0) {
                    links = feld[y][x-1];
                } else {
                    links = LEER;
                }


                /* unterer Nachbar */
                if(y > 0) {
                    unten = feld[y-1][x];
                    while(label[unten] < unten) unten = label[unten];
                } else {
                    unten = LEER;
                }

                if(links == LEER  &&  unten == LEER) {
                    feld[y][x] = neu;
                    label[neu] = neu; neu++;   /* neue Nummer vergeben */
                } else if(links < unten) {
                    feld[y][x] = links;
                    if(unten < LEER) label[unten] = links;   /* Cluster verbinden */
                } else {
                    feld[y][x] = unten;
                    if(links < LEER) label[links] = unten;  /* Cluster verbinden */
                }
            } /* besetzter Punkt */
        }

    /* vorlaeufige Nummerierung fertig */

    for(y = 0; y < L; y++) for(x = 0; x < L; x++) {
            n = feld[y][x];
            while(label[n] < n) n = label[n];   /* gutes Label finden */
            if(n == LEER) {
                feld[y][x] = -1;     /* Leerstellen -> -1 */
            } else {
                feld[y][x] = n;
            }
        }
    free(label);
}