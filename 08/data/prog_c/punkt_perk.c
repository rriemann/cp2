/*    file punkt_perk.c
      main zu Punktperkolation */

#define  Lp 100          /* Gittergroesse: Lp x Lp */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "R250.h"
#include "cluster_analyse.h"

void print_field(int** feld, int L);

int main(void){

    int x;

    int **feld, **feld1; /* Status der Gitterpunkte:
			    feld = -1 : unbesetzt
			    =  0 : besetzt
			    >  0 : Clusternummer
			    */
    int *fp;

    double p  = 0.4;   /* Aktivierungswahrscheinlichkeit */

    int  seed = 137;   /* Seed fuer R250 */

    int    L  = Lp;    /* Gittergroesse als Variable */

    initR250(seed);    /* Initialisierung von R250 */

    /* Allokation der Felder */
    feld=malloc(L*sizeof(int*));
    feld[0]=malloc(L*L*sizeof(int));
    if (feld[0]==NULL ) {
	fprintf(stderr,"Not enough memory for feld\n");
	exit(1);
    }
    for (x=1;x<L;x++) feld[x]=feld[0]+L*x; 

    feld1=malloc(L*sizeof(int*));
    feld1[0]=malloc(L*L*sizeof(int));
    if (feld1[0]==NULL ) {
	fprintf(stderr,"Not enough memory for feld1\n");
	exit(1);
    }

    for (x=1;x<L;x++) feld1[x]=feld1[0]+L*x; 

    /* Belegung des Feldes mit Zufallseintraegen*/
    fp =feld[0];
    for (x = 0; x < L*L; x++){
	if (R250() < p) *fp = 0; 
	else            *fp = -1;
	fp++;
    }
    memcpy(feld1[0],feld[0],L*L*sizeof(int)); /* Kopie fuer Vergleich der Algorithmen */


    printf("\n Punktbesetzung:");
    print_field(feld,L);

    /* Cluster identifizieren: Baumsuche*/
    baum_analyse(feld,L);         
    printf("\n Ergebnis Baumsuche:");
    print_field(feld,L);


    /* Cluster identifizieren: Hoshen&Kopelman */
    hoshen_kopelman(feld1,L);         
    printf("\n Ergebnis Hoshen Kopelmann:");
    print_field(feld1,L);

    return 0;
}     /* main */

/*Ausgabe des Feldes auf dem Bildschirm */
void print_field(int **feld, int L)
{
    int x,y;
    for (y = L-1; y >= 0; y--){
	printf("\n");
	for (x = 0; x < L; x++)
	    printf("%4i",feld[y][x]);     /* Clusterzerlegung ausdrucken */
    }
    printf("\n");
}


#undef  Lp
