#include <stdio.h>
#include <stdlib.h>
//#include "cpu.h"
#include "../inc/cpu.h"
#include "../inc/loader.h"
#define MEM_SIZE 0x5000
int main(int argc, char* argv[]) {
    uint8_t* memory;
    //struct rv32i_cpu cpu;
    char *hexfile;

    if(argc != 2) {
        printf("Please specify the hex file\n");
        exit(EXIT_FAILURE);
    }
    
    hexfile = argv[1];

    //create and init system memory
    memory = (uint8_t *)malloc(MEM_SIZE);

    //load executable file to system memory
    hex2mem(hexfile, memory);
    for(int i = 0x468;i<0x468+20;i++){
        printf("memory[0x%03x] = %x\n",i, memory[i]);
    }
    //cpu.start_addr = 0x80;
    //create cpu inst
    //set cpu start address
    //run(&cpu, memory);
    return 0;
}