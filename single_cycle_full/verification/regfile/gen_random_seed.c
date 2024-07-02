#include <stdlib.h>
#include <stdio.h>
#include <time.h>
void main(void) {
    srand(time(0));
    FILE* fp;
    fp = fopen("seed.txt", "w");
    fprintf(fp,"%0d",rand());
    fclose(fp);
}