#include "cpu.h"
#include <stdlib.h>
void run(struct rv32i_cpu* cpu, uint8_t* memory) {
    uint32_t inst;
    uint32_t opcode;

    while(1) {
        //instruction fetch
        inst = fetch_inst(memory, cpu->pc);
        //decode
        opcode = inst & 127;
        switch (opcode)
        {
        case R_TYPE: EXE_R_TYPE(cpu, inst, 0); break;
        case IR_TYPE: EXE_R_TYPE(cpu, inst, 1); break;
        case LOAD:
            break;
        case S_TYPE:
            /* code */
            break;
        case LUI:
            /* code */
            break;
        case AUIPC:
            /* code */
            break;
        case JAL:
            /* code */
            break;
        case JALR:
            /* code */
            break;
        default:
            break;
        }
        ra1 = (inst >> 15) & 31;
        ra2 = (inst >> 20) & 31;
        rd1 = get_gpr(cpu, ra1);
        rd2 = get_gpr(cpu, ra2);
        imm = imm_gen(inst);
        //decode for control signals
        switch (opcode)
        {
        case:
            break;
        
        default:
            break;
        }
        //exe::alu
        rd2 = ALUSrc ? imm : rd2;
        //result = alu(ALUOp, rd1, ra2);
        //mem access
        
        //write back to register

        //update pc
        /*
        if(debug_mode){
            print all register and pc 
        }
        */
    }
}

uint32_t fetch_inst(uint8_t* memory, uint32_t addr) {
    if (addr & 3 != 0) {
        printf("addr = 0x%x\n",addr);
        printf("misalign!!\n");
        exit(EXIT_FAILURE);
    }
    return ((uint32_t *)memory)[addr];
}

uint32_t decode_inst(uint32_t inst) {

}

uint32_t alu(enum ALUOp alu_op, uint32_t a, uint32_t b) {
    uint32_t result;
    switch (alu_op)
    {
    case ADD:  result = a + b;  break;
    case SUB:  result = a - b;  break;
    case SLL:  result = a << b; break;
    case SLT:  result = (((int32_t)a) < ((int32_t)b));break;
    case SLTU: result = (a < b);break;
    case XOR:  result = a ^ b;  break;
    case SRL:  result = a >> b; break;
    case SRA:  result = ((int32_t)a) >> b;break;
    case OR:   result = a | b;  break;
    case AND:  result = a & b;  break;
    default:
        break;
    }
    return result;
}

uint32_t get_gpr(struct rv32i_cpu* cpu, int gpr_idx) {
    if (gpr_idx == 0) {
        return 0;
    }
    return cpu->x[gpr_idx];
}
void set_gpr(struct rv32i_cpu* cpu, int gpr_idx, uint32_t value) {
    if (gpr_idx > 0) {
        cpu->x[gpr_idx] = value;
    }
}

uint32_t mem_read(uint8_t* memory, uint32_t addr){
    return ((uint32_t *)memory)[addr];
}
uint32_t mem_write(uint8_t* memory, uint32_t addr, uint32_t data, int wstrb){
        uint8_t* data_ptr = &data;
        if (wstrb & 1) memory[0] = data_ptr[0]; //0001 = 1
        if (wstrb & 2) memory[1] = data_ptr[1]; //0010 = 2
        if (wstrb & 4) memory[2] = data_ptr[2]; //0100 = 4
        if (wstrb & 8) memory[3] = data_ptr[3]; //1000 = 8
}
uint32_t imm_gen(uint32_t inst) {
    //fix me
    return;
}

void EXE_R_TYPE(struct rv32i_cpu* cpu, uint32_t inst, int alu_source) {
    uint32_t result;
    uint32_t ra1 = (inst >> 15) & 31;
    uint32_t ra2 = (inst >> 20) & 31;
    uint32_t rd1 = get_gpr(cpu, ra1);
    uint32_t rd2 = (alu_source) ? imm_gen(inst) : get_gpr(cpu, ra2);
    uint32_t wa = (inst >> 7) & 31;
    uint32_t func3 = (inst >> 12) & 8;
    uint32_t func7_bit6 = (inst >> 30) & 1;
    enum ALUOp alu_op;
    switch (func3)
    {
    case 0://ADD or SUB
        if (func7_bit6) 
            alu_op = SUB;
        else
            alu_op = ADD;
        break;
    case 1: alu_op = SLL; break;
    case 2: alu_op = SLT; break;
    case 3: alu_op = SLTU;break;
    case 4: alu_op = XOR; break;
    case 5:
        if(func7_bit6)
            alu_op = SRA;
        else
            alu_op = SRL;
        break;
    case 6: alu_op = OR;  break;
    case 7: alu_op = AND; break;
    default:
        printf("decode alu operation error!!\n\n");
        exit(EXIT_FAILURE);
        break;
    }
    result = alu(alu_op, rd1, rd2);
    set_gpr(cpu, wa, result);
    cpu->pc = cpu->pc + 0x4;
}

void EXE_LOAD(struct rv32i_cpu* cpu, uint32_t inst, uint8_t* memory) {

}
void EXE_S_TYPE(struct rv32i_cpu* cpu, uint32_t inst, uint8_t* memory) {

}
void EXE_LUI(struct rv32i_cpu* cpu, uint32_t inst) {

}
void EXE_AUIPC(struct rv32i_cpu* cpu, uint32_t inst) {

}
void EXE_JAL(struct rv32i_cpu* cpu, uint32_t inst) {

}
void EXE_JALR(struct rv32i_cpu* cpu, uint32_t inst) {

}

uint32_t get_inst_opcode(uint32_t inst){

}

uint32_t get_inst_rs1(uint32_t inst){

}

uint32_t get_inst_rs2(uint32_t inst){

}

uint32_t get_inst_rd_shamt(uint32_t inst){

}

uint32_t get_inst_func3(uint32_t inst){

}

uint32_t get_inst_func7(uint32_t inst){

}
