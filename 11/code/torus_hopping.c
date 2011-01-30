/* torus_hopping; modification of torus_hop.c by U.Wolff  */
/* OW JUN2006 */


/*    Bewegungen zu naechsten Nachbarn auf dem Torus
      der Kantenlaenge L in D Dimensionen und Volumen V=L^D.

      Seien im Hauptprogramm die Laenge L, Dimension und das Volumen V
      definiert, sowie das Feld  int hop[V][2*D]; definiert.
      Dann werden durch den Aufruf 
      torus_hopping(&hop[0][0], L, D);
      die naechsten Nachbarn berechnet und ins Feld hop geschrieben.
 
      Jeder Torus-Punkt x=(x_0,...,x_{D-1}) wird numeriert mit
      n_x=x_0 + x_1*L + x_2*L^2 + ... + x_{D-1}*L^{D-1};
      hop[n_x][mu]   enthaelt den Index von x+mu_hat,
      hop[n_x][mu+D] enthaelt den Index von x-mu_hat,
      (mu_hat = Einheitsvektor) 


      Das zwei-dimensionale Array hop liegt ein-dimensional im Speicher 
      und wird hier durch explizite Adressberechnung mit nur einem Index
      addressiert. 
*/

#include <stdio.h>
#include <stdlib.h>


void torus_hopping(int *hop, int L, int D ){
    int V, Lmu, n_x, r_x, i;
    int mu, x_mu, x_muP, x_muM;

    /* Berechne Volumen*/
    V=1;
    for (i = 0; i < D; i++) V = V*L; 

    for (n_x=0; n_x < V ; n_x++){
	Lmu = V;
	r_x=n_x;
	for (mu=D-1; mu >= 0; mu--){
	    Lmu=Lmu/L;                     /* = L^mu */
	    x_mu=r_x/Lmu;                  /* mu'te Komponente rausholen */
	    r_x=r_x-x_mu*Lmu;              /* Restindex aus x_0 .. x_(mu-1) */

	    x_muP=(x_mu+1)%L;              /* vorwaerts, modulo wg Ueberlauf */ 
	    hop[2*D*n_x + mu]   = n_x + (x_muP-x_mu)*Lmu;

	    x_muM=(x_mu-1+L)%L;            /* rueckwaerts, '+L' fuer korrekten Ueberlauf */
	    hop[2*D*n_x+(mu+D)] = n_x + (x_muM-x_mu)*Lmu;
	}
    }
} /* torus_hopping */

