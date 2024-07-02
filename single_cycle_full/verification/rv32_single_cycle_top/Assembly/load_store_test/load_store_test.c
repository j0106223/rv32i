#include <stdlib.h>
#include <stdio.h>
#define BASE 1024
#define SIZE 1024
void main(void) {
    printf("_load_store_test:\n");
    for(int i = 0; i < SIZE/4/2; i++){
        printf("\tlw    t0, 0x%0x(x0)\n",((BASE+SIZE/2) + (i*4)));
        printf("\tsw    t0, 0x%0x(x0)\n",((BASE) + (i*4)));
    }
}