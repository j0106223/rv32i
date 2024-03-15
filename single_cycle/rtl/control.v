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
    output wire       Branch;
    output wire       MemRead;
    output wire       MemtoReg;
    output wire [1:0] ALUOp;
    output wire       MemWrite;
    output wire       ALUSrc;
    output wire       RegWrite;

    wire [6:0]i     = opcode;//just rename
    wire R_format   = ~i[6] &  i[5] &  i[4] & ~i[3] & ~i[2] & i[1] & i[0];//0110011
    wire lw         = ~i[6] & ~i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0];//0000011
    wire sw         = ~i[6] &  i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0];//0100011
    wire beq        =  i[6] &  i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0];//1100011
    
    
    assign  Branch   = beq;
    assign  MemRead  = lw;
    assign  MemtoReg = lw;
    assign  ALUOp[1] = R_format;
    assign  ALUOp[0] = beq;
    assign  MemWrite = sw;
    assign  ALUSrc   = lw | sw;
    assign  RegWrite = R_format | lw;
endmodule