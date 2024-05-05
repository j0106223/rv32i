#include <stdint.h>

#define R_TYPE 51   // 0110011
#define IR_TYPE 19  // 0010011
#define LOAD 3      // 0000011
#define S_TYPE 35   // 0100011
#define B_TYPE 99   // 1100011
#define LUI 55      // 0110111
#define AUIPC 23    // 0010111
#define JAL 111     // 1101111
#define JALR 103    // 1100111
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
