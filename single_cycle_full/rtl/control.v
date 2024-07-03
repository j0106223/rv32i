`default_nettype none
module control (
    opcode,
    Branch,
    MemRead,
    MemtoReg,
    ALUOp,
    MemWrite,
    ALUSrc,
    RegWrite
);

    input  wire [6:0] opcode;
    input  wire [2:0] func3;
    output wire       Branch;
    output wire       MemRead;
    output wire       MemtoReg;
    output wire [1:0] ALUOp;
    output wire       MemWrite;
    output wire [3:0] Wstrb;
    // load sign extend
    output 
    output wire       ALUSrc;
    output wire       RegWrite;

    wire [6:0]i     = opcode;//just rename
    wire R_format   = ~i[6] &  i[5] &  i[4] & ~i[3] & ~i[2] & i[1] & i[0];//0110011
    
    wire load = (opcode == 7'b0000011);
    wire lb  = load & (func3 == 3'b000);
    wire lh  = load & (func3 == 3'b001);
    wire lw  = load & (func3 == 3'b010);
    wire lbu = load & (func3 == 3'b100);
    wire lhu = load & (func3 == 3'b101);

    wire store = (opcode == 7'b0100011);
    wire sb = store & (func3 == 3'b000);
    wire sh = store & (func3 == 3'b001);
    wire sw = store & (func3 == 3'b010);
    wire beq        =  i[6] &  i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0];//1100011
    wire lui        = ~i[6] &  i[5] &  i[4] & ~i[3] &  i[2] & i[1] & i[0];//0110111
    wire auipc      = ~i[6] & ~i[5] &  i[4] & ~i[3] &  i[2] & i[1] & i[0];//0010111
    wire jal        =  i[6] &  i[5] & ~i[4] &  i[3] &  i[2] & i[1] & i[0];//1101111
    wire jalr       =  i[6] &  i[5] & ~i[4] & ~i[3] &  i[2] & i[1] & i[0];//1100111

    wire lhu;
    
    assign  Branch   = beq;
    assign  MemRead  = load;
    assign  MemtoReg = load;
    assign  ALUOp[1] = R_format;
    assign  ALUOp[0] = beq;
    assign  MemWrite = store;
    assign  ALUSrc   = load | store;
    assign  RegWrite = R_format | load;
endmodule