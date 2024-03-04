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

    input [6:0] opcode;
    output      Branch;
    output      MemRead;
    output      MemtoReg;
    output[1:0] ALUOp;
    output      MemWrite;
    output      ALUSrc;
    output      RegWrite;

    wire [6:0]i     = opcode;//just rename
    wire R_format   =  i[4];         //0110011
    wire lw         = ~i[6] & ~i[5]; //0000011
    wire sw         = ~i[6] &  i[5]; //0100011
    wire beq        =  i[6];         //1100011
    
    
    assign  Branch   = beq;
    assign  MemRead  = lw;
    assign  MemtoReg = lw;
    assign  ALUOp[1] = R_format;
    assign  ALUOp[0] = beq;
    assign  MemWrite = sw;
    assign  ALUSrc   = lw | sw;
    assign  RegWrite = R_format | lw;
endmodule