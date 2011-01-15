/* R250 Shift-Register Zufallszahlen Generator */


extern void initR250(int seed);
extern int saveR250(char *fname);
extern int loadR250(char *fname);
extern double R250(void);
extern int printI250(void);
