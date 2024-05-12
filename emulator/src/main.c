#include <stdio.h>
#include <stdlib.h>
#include "cpu.h"
int main(void) {
    uint8_t* memory;
    int bin_size;
    //check executable file size 
    //create and init system memory
    memory = (uint8_t *)malloc(bin_size);
    //load executable file to system memory
    struct rv32i_cpu cpu;
    cpu.start_addr = 0x80;
    //create cpu inst
    //set cpu start address
    run(&cpu, memory);
    return 0;
}