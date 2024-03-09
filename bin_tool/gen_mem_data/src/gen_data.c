#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#define BASE 0x1000
#define SIZE 1024
void init_mem(int base, int size, int init_value);
void init_mem_random(int base, int size);
FILE* fp;
int main(int argc, char* argv[]) {
    
    fp = fopen("data.hex","w");
    init_mem(BASE, 512, 0);
    init_mem_random(BASE + 512, 512);
    fclose(fp);
    return 0;
}
void init_mem(int base, int size, int init_value) {
    fprintf(fp, "@%08x\n", base);
    for(int i = 0;i < size; i++) {
        fprintf(fp, "%02x", init_value);
        if(((i+1) % 16 == 0)){
            fprintf(fp,"\n");
        } else {
            fprintf(fp," ");
        }
    }
    fprintf(fp, "\n");
}
void init_mem_random(int base, int size){
    fprintf(fp, "@%08x\n", base);
    for(int i = 0;i < size; i++) {
        fprintf(fp, "%02x", rand() & 0x000000FF);
        if(((i+1) % 16 == 0)){
            fprintf(fp, "\n");
        } else {
            fprintf(fp, " ");
        }
    }
    fprintf(fp, "\n");
}