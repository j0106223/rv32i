#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
int hex2mem(char* filename, uint8_t* memory) {    
    FILE* fp;
    uint32_t addr;
    uint8_t data;
    char buffer[20];
    
    fp = fopen(filename, "r");
    if (fp == NULL) {
        return -1;
    }

    while(fscanf(fp,"%s",buffer) != EOF) {
        if (buffer[0]=='@') {
            addr = strtol((buffer+1), NULL, 16);
        } else {
            data = (uint8_t)strtol(buffer, NULL, 16);
            memory[addr] = data;
            addr++;
        }
    }

    fclose(fp);
    return 0;
}