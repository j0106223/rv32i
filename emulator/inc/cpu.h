#ifndef __CPU_HEADER__
#define __CPU_HEADER__
#include <stdint.h>

#ifndef DEBUG
    #define debug_print(fmt, args...)
#else
    #define debug_print printf
#endif

#define UART_BASE 0x08000000
#define R_TYPE 51   // 0110011
#define IR_TYPE 19  // 0010011
#define LOAD 3      // 0000011
#define S_TYPE 35   // 0100011
#define B_TYPE 99   // 1100011
#define LUI 55      // 0110111
#define AUIPC 23    // 0010111
#define JAL 111     // 1101111
#define JALR 103    // 1100111
#define SYSTEM 115  // 1110011
struct rv32i_cpu
{
    uint32_t pc;
    uint32_t x[32];
    uint32_t start_addr;//a.k.a reset vector
};

enum ALUOp {
    ADD,
    SUB,
    SLL,
    SLT,
    SLTU,
    XOR,
    SRL,
    SRA,
    OR,
    AND
};

void run(struct rv32i_cpu* cpu, const uint32_t reset_vector, uint8_t* memory);
#endif


