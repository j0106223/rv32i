#include <stdio.h>
#include <stdlib.h>
#include "cpu.h"


uint32_t get_pc(struct rv32i_cpu* cpu);
void set_pc(struct rv32i_cpu* cpu, uint32_t target_pc); 
uint32_t get_inst_field(uint32_t inst, int msb, int lsb);
uint32_t get_inst_bit(uint32_t inst, int idx);
uint32_t get_inst_opcode(uint32_t inst);
uint32_t get_inst_rs1(uint32_t inst);
uint32_t get_inst_rs2(uint32_t inst);
uint32_t get_inst_rd(uint32_t inst);
uint32_t get_inst_func3(uint32_t inst);
uint32_t get_inst_func7(uint32_t inst);
uint32_t imm_gen(uint32_t inst);
void set_gpr(struct rv32i_cpu* cpu, int gpr_idx, uint32_t value);
uint32_t mem_read(uint8_t* memory, uint32_t addr);
void mem_write(uint8_t* memory, uint32_t addr, uint32_t data, int wstrb);
uint32_t get_gpr(struct rv32i_cpu* cpu, int gpr_idx);
void EXE_JAL(struct rv32i_cpu* cpu, uint32_t inst);
void EXE_JALR(struct rv32i_cpu* cpu, uint32_t inst);
void EXE_AUIPC(struct rv32i_cpu* cpu, uint32_t inst); 
void EXE_LUI(struct rv32i_cpu* cpu, uint32_t inst);
void EXE_B_TYPE(struct rv32i_cpu* cpu, uint32_t inst); 
void EXE_S_TYPE(struct rv32i_cpu* cpu, uint32_t inst, uint8_t* memory);
void EXE_LOAD(struct rv32i_cpu* cpu, uint32_t inst, uint8_t* memory);
void EXE_R_TYPE(struct rv32i_cpu* cpu, uint32_t inst, int alu_source);
uint32_t alu(enum ALUOp alu_op, uint32_t a, uint32_t b);
uint32_t fetch_inst(uint8_t* memory, uint32_t addr);


int cnt = 0;
//riscv register calling convention
const char* reg_name[32] = {
            "zero",
            "ra",
            "sp",
            "gp",
            "tp",
            "t0","t1","t2",
            "s0",
            "s1",
            "a0","a1","a2","a3","a4","a5","a6","a7",
            "s2","s3","s4","s5","s6","s7","s8","s9","s10","s11",
            "t3","t4","t5","t6"
        };
void run(struct rv32i_cpu* cpu, uint8_t* memory) {
    uint32_t inst;
    uint32_t opcode;
    //cpu init
    cpu->pc = cpu->start_addr;
    while(1) {
        if(cnt++ > 80){
            return;
        }
        //instruction fetch
        inst = fetch_inst(memory, get_pc(cpu));
        printf("\npc = 0x%08x: inst = 0x%08x\t",cpu->pc, inst);
        opcode = inst & 127;
        switch (opcode)
        {
        case R_TYPE : EXE_R_TYPE(cpu, inst, 0);      break;
        case IR_TYPE: EXE_R_TYPE(cpu, inst, 1);      break;
        case LOAD   : EXE_LOAD(cpu, inst, memory);   break;
        case S_TYPE : EXE_S_TYPE(cpu, inst, memory); break;
        case B_TYPE : EXE_B_TYPE(cpu, inst);         break;
        case LUI    : EXE_LUI(cpu, inst);            break;
        case AUIPC  : EXE_AUIPC(cpu, inst);          break;
        case JAL    : EXE_JAL(cpu, inst);            break;
        case JALR   : EXE_JALR(cpu, inst);           break;
        default:
            break;
        }
    }
}

uint32_t fetch_inst(uint8_t* memory, uint32_t addr) {
    if (addr & 3 != 0) {
        printf("addr = 0x%x\n",addr);
        printf("misalign!!\n");
        exit(EXIT_FAILURE);
    }
    return mem_read(memory, addr);
}

uint32_t alu(enum ALUOp alu_op, uint32_t a, uint32_t b) {
    uint32_t result;
    switch (alu_op)
    {
    case ADD:  result = a + b;
        break;
    case SUB:  result = a - b;
        break;
    case SLL:  result = a << (b & 31);//shamt is 5-bit
        break;
    case SLT:  result = (((int32_t)a) < ((int32_t)b));
        break;
    case SLTU: result = (a < b);
        break;
    case XOR:  result = a ^ b;
        break;
    case SRL:  result = a >> (b & 31);//shamt is 5-bit
        break;
    case SRA:  result = ((int32_t)a) >> (b & 31);//shamt is 5-bit
        break;
    case OR:   result = a | b;
        break;
    case AND:  result = a & b;
        break;
    default:
        printf("not support aluop %d", alu_op);
        exit(EXIT_FAILURE);
        break;
    }
    return result;
}

void EXE_R_TYPE(struct rv32i_cpu* cpu, uint32_t inst, int alu_source) {
    uint32_t result;
    uint32_t rs1 = get_inst_rs1(inst);
    uint32_t rs2 = get_inst_rs2(inst);
    uint32_t rs1_data = get_gpr(cpu, rs1);
    uint32_t rs2_data = (alu_source) ? imm_gen(inst) : get_gpr(cpu, rs2);
    uint32_t rd = get_inst_rd(inst);
    uint32_t func3 = get_inst_func3(inst);
    uint32_t func7_bit6 = get_inst_bit(inst, 30);
    uint32_t target_pc = get_pc(cpu) + 4;
    enum ALUOp alu_op;

    switch (func3)
    {
    case 0://ADD or SUB
        if (func7_bit6 && !alu_source)
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
    result = alu(alu_op, rs1_data, rs2_data);
    set_gpr(cpu, rd, result);
    set_pc(cpu, target_pc);
}

void EXE_LOAD(struct rv32i_cpu* cpu, uint32_t inst, uint8_t* memory) {
    uint32_t func3 = get_inst_func3(inst);
    uint32_t rs1 = get_inst_rs1(inst);
    uint32_t rd = get_inst_rd(inst);
    uint32_t rs1_data = get_gpr(cpu, rs1); 
    uint32_t imm = imm_gen(inst);
    uint32_t addr = rs1_data + imm;
    uint32_t rd_data = mem_read(memory, addr);
    uint32_t target_pc = get_pc(cpu) + 4;
    //sign extend or zero extend
    switch (func3)
    {
    //LB
    case 0: rd_data = (int8_t)(rd_data & 0xF); break;
    //LH
    case 1: rd_data = (int16_t)(rd_data & 0xFF);  break;
    //LW
    case 2: break;
    //LBU
    case 4: rd_data = rd_data & 0xF; break;
    //LHU
    case 5: rd_data = rd_data & 0xFF;  break;
    default:
        printf("Load-Type decode error func3 = %x", func3);
        exit(EXIT_FAILURE);
        break;
    }
    set_gpr(cpu, rd, rd_data);
    set_pc(cpu, target_pc);
}
void EXE_S_TYPE(struct rv32i_cpu* cpu, uint32_t inst, uint8_t* memory) {
    uint32_t rs1 = get_inst_rs1(inst);
    uint32_t rs2 = get_inst_rs2(inst);
    uint32_t func3 = get_inst_func3(inst);
    uint32_t rs1_data = get_gpr(cpu, rs1);
    uint32_t rs2_data = get_gpr(cpu, rs2); 
    uint32_t imm = imm_gen(inst);
    uint32_t addr = rs1_data + imm;
    uint32_t target_pc = get_pc(cpu) + 4;
    //sw a0, offset(a1)
    switch (func3)
    {
    //SB
    case 0: mem_write(memory, addr, rs2_data, 0x1); break;
    //SH
    case 1: mem_write(memory, addr, rs2_data, 0x3); break;
    //SW
    case 2: mem_write(memory, addr, rs2_data, 0xf); break;
    
    default:
        printf("S-Type decode error func3 = %x", func3);
        exit(EXIT_FAILURE);
        break;
    }
    set_pc(cpu, target_pc);
}
void EXE_B_TYPE(struct rv32i_cpu* cpu, uint32_t inst) {
    uint32_t rs1 = get_inst_rs1(inst);
    uint32_t rs2 = get_inst_rs2(inst);
    uint32_t func3 = get_inst_func3(inst);
    uint32_t rs1_data = get_gpr(cpu, rs1);
    uint32_t rs2_data = get_gpr(cpu, rs2); 
    uint32_t imm = imm_gen(inst);
    uint32_t target_pc;
    switch(func3)
    {
        //BEQ
        case 0:
            if(rs1_data == rs2_data) {
                target_pc = get_pc(cpu) + imm;
            } else {
                target_pc = get_pc(cpu) + 4;
            }
            break;
        //BNE
        case 1:
            if(rs1_data != rs2_data) {
                target_pc = get_pc(cpu) + imm;
            } else {
                target_pc = get_pc(cpu) + 4;
            }
            break;
        //BLT
        case 4:
            if ((int32_t)rs1_data < (int32_t)rs2_data) {
                target_pc = get_pc(cpu) + imm;
            } else {
                target_pc = get_pc(cpu) + 4;
            }
            break;
        //BGE
        case 5:
            if ((int32_t)rs1_data >= (int32_t)rs2_data) {
                target_pc = get_pc(cpu) + imm;
            } else {
                target_pc = get_pc(cpu) + 4;
            }
            break;
        //BLTU
        case 6:
            if (rs1_data < rs2_data) {
                target_pc = get_pc(cpu) + imm;
            } else {
                target_pc = get_pc(cpu) + 4;
            }
            break;
        //BGEU
        case 7:
            if (rs1_data >= rs2_data) {
                target_pc = get_pc(cpu) + imm;
            } else {
                target_pc = get_pc(cpu) + 4;
            }
            break;
        default:
            printf("B-Type decode error func3 = %x", func3);
            exit(EXIT_FAILURE);
            break;
    }
    set_pc(cpu, target_pc);
}
void EXE_LUI(struct rv32i_cpu* cpu, uint32_t inst) {
    uint32_t rd = get_inst_rd(inst);
    uint32_t imm = imm_gen(inst);
    uint32_t target_pc = get_pc(cpu) + 4;
    set_gpr(cpu, rd, imm);
    set_pc(cpu, target_pc);
}
void EXE_AUIPC(struct rv32i_cpu* cpu, uint32_t inst) {
    uint32_t rd = get_inst_rd(inst);
    uint32_t imm = imm_gen(inst);
    uint32_t rd_data = imm + get_pc(cpu);
    uint32_t target_pc = get_pc(cpu) + 4;
    set_gpr(cpu, rd, rd_data);
    set_pc(cpu, target_pc);
}
void EXE_JAL(struct rv32i_cpu* cpu, uint32_t inst) {
    uint32_t rd = get_inst_rd(inst);
    uint32_t imm = imm_gen(inst);
    uint32_t rd_data = get_pc(cpu) + 4;
    uint32_t target_pc = get_pc(cpu) + imm;
    set_gpr(cpu, rd, rd_data);
    set_pc(cpu, target_pc);
}

void EXE_JALR(struct rv32i_cpu* cpu, uint32_t inst) {
    uint32_t rs1 = get_inst_rs1(inst);
    uint32_t rd = get_inst_rd(inst);
    uint32_t imm = imm_gen(inst);
    uint32_t rd_data = get_pc(cpu) + 4;
    uint32_t rs1_data = get_gpr(cpu, rs1);
    uint32_t target_pc = rs1_data + imm;;
    set_gpr(cpu, rd, rd_data);
    set_pc(cpu, target_pc);
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
    printf("%s = %d\n", reg_name[gpr_idx], (int)get_gpr(cpu, gpr_idx));
    //printf("%s = 0x%08x\n", reg_name[gpr_idx], get_gpr(cpu, gpr_idx));
}

uint32_t mem_read(uint8_t* memory, uint32_t addr){
    return *((uint32_t *)(memory + addr));
}

void mem_write(uint8_t* memory, uint32_t addr, uint32_t data, int wstrb){
        uint8_t* data_ptr = (uint8_t *)&data;

        if (wstrb & 1) memory[addr]   = data_ptr[0]; //0001 = 1
        if (wstrb & 2) memory[addr+1] = data_ptr[1]; //0010 = 2
        if (wstrb & 4) memory[addr+2] = data_ptr[2]; //0100 = 4
        if (wstrb & 8) memory[addr+3] = data_ptr[3]; //1000 = 8
        printf("memory update addr: 0x%08x, data = 0x%08x",addr, data);
}

uint32_t imm_gen(uint32_t inst) {
    uint32_t imm;
    uint32_t sign_bit = get_inst_bit(inst, 31);
    uint32_t opcode = get_inst_opcode(inst);
    switch (opcode)
    {
    //I-type
    case IR_TYPE:
    case LOAD:
    case JALR:
        imm = get_inst_field(inst, 31, 20);
        if (sign_bit) {
            imm = imm | 0xFFFFF000;
        }
        break;
    //S-type
    case S_TYPE:
        imm = (get_inst_field(inst, 31, 25) << 5) | get_inst_field(inst, 11, 7);
        if(sign_bit) {
            imm = imm | 0xFFFFF000;
        }
        break;
    //B-type
    case B_TYPE:
        imm = (get_inst_field(inst, 30, 25) << 5)
             |(get_inst_field(inst, 11, 8) << 1)
             |(get_inst_bit(inst, 7) << 11);

        if (sign_bit) {
            imm = imm | 0xFFFFF000;
        }
        break;
    //U-type
    case LUI:
    case AUIPC:
        imm = inst & 0xFFFFF000;
        break;
    //J-type
    case JAL:
        imm = (get_inst_field(inst, 30, 21) << 1)
             |(get_inst_bit(inst, 20) << 11)
             |(get_inst_field(inst, 19, 12) << 12);
        if (sign_bit) {
            imm = imm | 0xFFF00000;
        }
        break;
    default:
        printf("imm_gen() decode error opcode = %x", opcode);
        exit(EXIT_FAILURE);
        break;
    }
    return imm;
}

uint32_t get_inst_opcode(uint32_t inst){
    return inst & 127;
}

uint32_t get_inst_rs1(uint32_t inst){
    return (inst >> 15) & 31;
}

uint32_t get_inst_rs2(uint32_t inst){
    return (inst >> 20) & 31;
}

uint32_t get_inst_rd(uint32_t inst){
    return (inst >> 7) & 31;
}

uint32_t get_inst_func3(uint32_t inst){
    return (inst >> 12) & 7;
}

uint32_t get_inst_func7(uint32_t inst){
    return (inst >> 25) & 127;
}

uint32_t get_inst_bit(uint32_t inst, int idx) {
    return (inst >> idx) & 1;
}
uint32_t get_inst_field(uint32_t inst, int msb, int lsb) {
    int field_size = msb - lsb + 1;
    uint32_t field_mask;
    if (msb < lsb) {
        printf("msb = %d\n", msb);
        printf("lsb = %d\n", lsb);
        printf("get_inst_field() msb should not small than lsb!!\n");
        exit(EXIT_FAILURE);
    }
    field_mask = (1 << field_size) - 1;
    return (inst >> lsb) & field_mask;
}
void set_pc(struct rv32i_cpu* cpu, uint32_t target_pc) {
    if((target_pc & 3) != 0) {
        printf("target pc = 0x%x\n", target_pc);
        printf("misalign!!\n");
        exit(EXIT_FAILURE);
    }
    cpu->pc = target_pc;
}
uint32_t get_pc(struct rv32i_cpu* cpu) {
    if ((cpu->pc & 3) != 0) {
        printf("current pc = 0x%x\n", cpu->pc);
        printf("misalign!!\n");
        exit(EXIT_FAILURE);
    }
    return cpu->pc;
}