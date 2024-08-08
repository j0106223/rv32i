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

    wire R_format   = (opcode == 7'b0110011);//0110011
    
    wire load  = (opcode == 7'b0000011);
    wire store = (opcode == 7'b0100011);

    wire lui        = ~i[6] &  i[5] &  i[4] & ~i[3] &  i[2] & i[1] & i[0];//0110111
    wire auipc      = ~i[6] & ~i[5] &  i[4] & ~i[3] &  i[2] & i[1] & i[0];//0010111
    wire jal        =  i[6] &  i[5] & ~i[4] &  i[3] &  i[2] & i[1] & i[0];//1101111
    wire jalr       =  i[6] &  i[5] & ~i[4] & ~i[3] &  i[2] & i[1] & i[0];//1100111

    wire lhu;
    
    assign  Branch   = (opcode == 7'b1100011);
    assign  MemRead  = load;
    assign  MemtoReg = load;
    assign  ALUOp[1] = R_format;
    assign  ALUOp[0] = Branch;
    assign  MemWrite = store;
    assign  ALUSrc   = load | store;
    assign  RegWrite = R_format | load;
endmodule