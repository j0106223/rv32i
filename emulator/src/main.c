#include <stdio.h>
#include <stdlib.h>
#include "cpu.h"
#include "loader.h"
#define MEM_SIZE 0x1000
int main(int argc, char* argv[]) {
    uint8_t* memory;
    struct rv32i_cpu cpu;
    char *hexfile;

    if(argc != 2) {
        printf("Please specify the hex file\n");
        exit(EXIT_FAILURE);
    }
    
    hexfile = argv[1];

    //create and init system memory
    memory = (uint8_t *)malloc(MEM_SIZE);
    if (memory == NULL) {
        printf("Declare too large memory\n");
        exit(EXIT_FAILURE);
    }
    //load executable file to system memory
    if (hex2mem(hexfile, memory) == -1){
        printf("cant open %s file\n",hexfile);
        exit(EXIT_FAILURE);
    }

    //set cpu start address
    cpu.start_addr = 0x00;
    
    run(&cpu, memory);
    return 0;
}