/* R250.c
   R250 Shift-Register Zufallszahlen Generator

   Bevor Zufallszahlen erzeugt werden, muss einmalig die Initialisierung
   mit initR250 durchgefuehrt werden. Sonst ist der Rueckgabewert negativ. */


#include <stdlib.h>
#include <stdio.h>
#include "R250.h"

static unsigned int I[250];
static int i1;
static double maxINV = -1.0;

/*****************************************************************************/
/* void initR250
   Initialisierung des R250 Shift-Register Zufallszahlengenerators. Hierzu
   wird zunaechst rand() mittels srand(seed) initialisiert. Da rand()
   Integerzahlen liefert, werden diese durch RAND_MAX dividiert und
   anschliessend mit dem maximalen Integer multipliziert.
   Diese Integerzahlen initialisieren das globale Array I, welches nach-
   folgend noch mit zwei warm-up Runden des R250 durchmischt wird.
   Der Positionsindex i1 (auf  ein Element von I) wird auf 0 gesetzt
   und der Wert des inversen maximalen Integers (maxINV) ermittelt. */

extern void initR250(int seed)
{
    unsigned int m;
    int k;
    double d;
    /* maximalen Integer erzeugen und invertieren */
    m = ~0;
    maxINV = 1.0 / ((double) m);

    /* Initialisierung mit einfachen rand() */
    srand(seed);
    for(k = 0; k < 250; k++)
        I[k] = (unsigned int)((rand() / (double) RAND_MAX) * m);

    i1 = 0;                         /* setzen des Startvektors */

    /* zwei weitere warm-up Runden mit R250 */
    for(k = 0; k < 500; k++)
        d = R250();
}


/*****************************************************************************/
/* int saveR250
   Speichert Zustand des R250 Generators als binary file, der Dateiname wird
   als Argument gegeben. Rueckgabewert ist 0 bei fehlerfreier IO und 1 bei
   einem Fehler. */

extern int saveR250(char *fname)
{
    FILE *out;
    out = fopen(fname, "w");
    if(out) {
        fwrite(&i1, sizeof(int), 1, out);
        fwrite(&I[0], sizeof(int), 250, out);
        fclose(out);
        return 0;
    } else {
        printf("ERROR WRITING R250 STATE TO FILE!\n");
        return 1;
    }
}


/*****************************************************************************/
/* int loadR250
   Laedt Zustand des R250 Generators aus einem binary file. Der Dateiname wird
   als Argument gegeben. Rueckgabewert ist 0, bei fehlerfreier IO, 1 bei Fehler
   und 2 falls maxINV sich unterscheidet (als Indikator fuer unterschiedlich
   grosse int Datentypen. */

extern int loadR250(char *fname)
{
    FILE *in;

    in = fopen(fname, "r");
    if(in) {
        fread(&i1, sizeof(int), 1, in);
        fread(&I[0], sizeof(int), 250, in);
        fclose(in);
        return 0;
    } else {
        printf("ERROR LOADING R250 STATE FROM FILE!\n");
        return 1;
    }
}


/*****************************************************************************/
/* double R250(void)
   Implementierung des R250 Shift-Register Zufallszahlengenerators.
   Rueckgabewert ist eine "Zufallszahl" in double. */

extern double R250(void)
{
    int i2;
    double d;
    /* Zweiter Positionsindex i2 wird ermittelt */
    i2 = (i1 >= 147) ? i1 - 147 : i1 + 103;

    I[i1] ^= I[i2];            /* BitXOR: I[i1]= I[i1]^I[i2]; */

    d = (I[i1]) * maxINV;             /* create double number */

    i1 = (i1 >= 249) ? 0 : i1 + 1;   /* Index i1 weitersetzen */

    return (d);
}

/*****************************************************************************/
/* printI250(void)
   Ausgabe der Elemente des globalen Array I, i1 und maxINV. */

extern int printI250(void)
{
    int k;

    for(k = 0; k < 250; k++)
        printf("%i \t %iu \n", k, I[k]);

    printf("i1 = %i \n", i1);
    printf("maxINV = %e \n", maxINV);
    return 0;
}
