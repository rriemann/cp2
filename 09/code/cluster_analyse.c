/*    file cluster_analyse.c
      Punkt-Perkolation */

#include <stdlib.h>
#include "cluster_analyse.h"

/*      Cluster-Analyse mit Baumsuche */

void baum_analyse(int **feld, int L){

    int xa, ya;                        /* Anfangspunkt eines Clusters */
    int cluster;                       /* Cluster-Nummer */
    int n;                             /* aktuelle Clustergroesse */
    int i;                             /* Arbeitspunkt in den Listen */
    int x, y;                          /* aktueller Punkt */

    int *xliste,*yliste;

    /* Arbeitslisten fuer Clustersuche dynamisch alloziert: */ 
    xliste = (int *) malloc(L*L*sizeof(int));
    yliste = (int *) malloc(L*L*sizeof(int));

    cluster = 0;
    for (ya = 0; ya < L; ya++) for (xa = 0; xa < L; xa++) 
    {
	if (feld[ya][xa] != 0) continue;
	cluster ++;             /* naechstes Cluster anfangen */
	feld[ya][xa] = cluster;
	xliste[0] = xa; yliste[0] = ya;
	n = 0; 
	i = -1;

	while (i < n) {
	    i++; 
	    x = xliste[i]; 
	    y = yliste[i]; 

	    if ((x < L-1) && (feld[y][x+1] == 0)) {     /* rechter Nachbar */
		feld[y][x+1] = cluster;
		n++; 
		xliste[n] = x+1; 
		yliste[n] = y;
	    } 

	    if ((x > 0) && (feld[y][x-1] == 0)) {       /* linker Nachbar */
		feld[y][x-1] = cluster;
		n++; 
		xliste[n] = x-1; 
		yliste[n] = y;
	    } 

	    if ((y < L-1) && (feld[y+1][x] == 0)) {     /* oberer Nachbar */
		feld[y+1][x] = cluster;
		n++; 
		xliste[n] = x; 
		yliste[n] = y+1;
	    } 

	    if ((y > 0) && (feld[y-1][x] == 0 )) {     /* unterer Nachbar */
		feld[y-1][x] = cluster;
		n++; 
		xliste[n] = x; 
		yliste[n] = y-1;
	    }

	}     /* while beendet: Cluster ist komplett */
	/* printf("cluster # %i : Groesse = %i\n",cluster,n+1); */
    }     /* xa &ya */

    free(xliste);
    free(yliste);

}  /* baum_analyse */


/*      Cluster-Analyse a la Hoshen Kopelman */

void hoshen_kopelman(int **feld, int L){

    int x, y ;                      /* aktueller Punkt, Feldindex = x+y*L */
    int neu;                        /* neue Clusternummer */
    int links, unten;               /* vorlaeufige Label der Nachbarn */
    int LEER;                       /* Label fuer Leerstellen */
    int n;

    int *label;

    /* Arbeitslist fuer Clustersuche dynamisch alloziert: */ 
    /* vorlaeufige -> endgueltige Num. */
    label = (int *) malloc((L*L+2)*sizeof(int));

    LEER = L*L+1; 
    label[LEER] = LEER;
    neu = 1;

    for (y = 0; y < L; y++) for (x = 0; x < L; x++) 
    {
	if (feld[y][x] == -1)         /* leerer Punkt */
	{
	    feld[y][x] = LEER;
	} else {                         /* besetzter Punkt */

	    /* linker Nachbar */
	    if (x > 0) {
		links = feld[y][x-1];
	    } else {
		links = LEER;          
	    }


	    /* unterer Nachbar */
	    if (y > 0) {
		unten = feld[y-1][x];
		while (label[unten] < unten) unten = label[unten];
	    } else {
		unten = LEER;         
	    }

	    if (links == LEER  &&  unten == LEER) {
		feld[y][x] = neu;
		label[neu] = neu; neu++;   /* neue Nummer vergeben */
	    }
	    else if (links < unten) {
		feld[y][x] = links;
		if (unten < LEER) label[unten] = links;  /* Cluster verbinden */
	    }
	    else {
		feld[y][x] = unten;
		if (links < LEER) label[links] = unten; /* Cluster verbinden */
	    }
	} /* besetzter Punkt */
    }       

    /* vorlaeufige Nummerierung fertig */

    for (y = 0; y < L; y++) for (x = 0; x < L; x++) {
	n = feld[y][x];
	while (label[n] < n) n = label[n];  /* gutes Label finden */
	if (n == LEER) {
	    feld[y][x] = -1;     /* Leerstellen -> -1 */
	} else {
	    feld[y][x] = n;
	}
    }
    free(label);
}     /* hoshen_kopelman */
