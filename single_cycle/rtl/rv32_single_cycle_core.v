`default_nettype none
module rv32_single_cycle_core (
    clk,
    reset_n,
    instruction,
    address,
    MemRead,
    MemWrite,
    wdata,
    rdata,
    pc
);
    parameter [31:0] RESET_VECTOR = 0;
    parameter AW = 32;
    parameter DW = 32;
    input             clk;
    input             reset_n;
    input      [31:0] instruction;
    output   [AW-1:0] address;
    output            MemRead;
    output            MemWrite;
    output   [DW-1:0] wdata;
    input    [DW-1:0] rdata;
    output reg [31:0] pc;
    
    // Decode
    wire   [6:0]    instruction_6_0   = instruction[6:0];
    wire   [4:0]    instruction_19_15 = instruction[19:15];
    wire   [4:0]    instruction_24_20 = instruction[24:20];
    wire   [4:0]    instruction_11_7  = instruction[11:7];
    wire   [31:0]   instruction_31_0  = instruction;
    wire   [2:0]    instruction_14_12  = instruction[14:12];
    
    // regfile
    wire   [31:0]   rd1;
    wire   [31:0]   rd2;

    wire   [31:0]   wd;

    // control
    wire            Branch;
    wire            MemRead;
    wire            MemtoReg;
    wire    [1:0]   ALUOp;
    wire            MemWrite;
    wire            ALUSrc;
    wire            RegWrite;

    // alu
    wire            ZERO;
    wire    [31:0]  rd2_ALU;
    wire     [3:0]  ALU_Operation;
    wire    [31:0]  ALU_result;
    
    // pc (program counter)
    wire   [31:0]   offset;
    wire   [31:0]   imm;
    assign offset = imm;

    wire   [31:0] pc_nx;
    assign pc_nx = (Branch && ZERO) ? pc+4 : pc+offset;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            pc <= RESET_VECTOR;
        end else begin
            pc <= pc_nx;
        end
    end

    assign wd = MemtoReg ? rdata : ALU_result;
    regfile regfile(
        .clk    (clk),
        .ra1    (instruction_19_15),//read1 address
        .ra2    (instruction_24_20),//read2 address
        .rd1    (rd1),              //read1 data
        .rd2    (rd2),              //read2 data
        .write  (RegWrite),
        .wa     (instruction_11_7), //write address
        .wd     (wd)                //write data
    );
    assign wdata = rd2;
    imm_gen imm_gen(
        .instruction(instruction_31_0),
        .imm        (imm)
    );
    control control(
        .opcode     (instruction_6_0),
        .Branch     (Branch),
        .MemRead    (MemRead),
        .MemtoReg   (MemtoReg),
        .ALUOp      (ALUOp),
        .MemWrite   (MemWrite),
        .ALUSrc     (ALUSrc),
        .RegWrite   (RegWrite)
    );

    alu_control alu_control (
        .instruction_funct3 (instruction_14_12),
        .instruction_funct7 (instruction[30]),  //just only needs take instruction[30],funct7[6]
        .ALUOp              (ALUOp),
        .ALU_Operation      (ALU_Operation)
    );

    assign rd2_ALU = ALUSrc ? imm: rd2;
    alu alu (
        .ALU_Operation  (ALU_Operation),
        .Data1          (rd1),
        .Data2          (rd2_ALU),
        .ALU_result     (ALU_result),
        .ZERO           (ZERO)
    );
    

endmodule