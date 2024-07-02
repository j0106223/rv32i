`timescale 1ns/1ps
module tb;
    int        fp;
    int        seed;
    reg   [6:0] opcode;

    localparam LW_opcode  = 7'b0000011;
    localparam SW_opcode  = 7'b0100011;
    localparam BEQ_opcode = 7'b1100011;
    localparam R_opcode   = 7'b0110011;

    localparam LW_control_signals  = 8'b01100011;
    localparam SW_control_signals  = 8'b00000110;
    localparam BEQ_control_signals = 8'b10001000;
    localparam R_control_signals   = 8'b00010001;
    wire       Branch;
    wire       MemRead;
    wire       MemtoReg;
    wire [1:0] ALUOp;
    wire       MemWrite;
    wire       ALUSrc;
    wire       RegWrite;
    wire [7:0] control_signals = {Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite};
    /*
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
    end
    */
    initial begin
        fp = $fopen("seed.txt","r");
        $fscanf(fp, "%d", seed);
        $display("seed = %d", seed);
        $fclose(fp);
    end

    initial begin
        for (int i = 0; i < 128; i++) begin
            opcode = i;
            #1;
            case(opcode)
                LW_opcode: if(control_signals != LW_control_signals)  $display("LW Fail");
                SW_opcode: if(control_signals != SW_control_signals)  $display("SW Fail");
                BEQ_opcode:if(control_signals != BEQ_control_signals) $display("BEQ Fail");
                R_opcode:  if(control_signals != R_control_signals)   $display("R Fail");
            endcase
        end
        $finish;
    end
    
    control control(
        .opcode     (opcode),
        .Branch     (Branch),
        .MemRead    (MemRead),
        .MemtoReg   (MemtoReg),
        .ALUOp      (ALUOp),
        .MemWrite   (MemWrite),
        .ALUSrc     (ALUSrc),
        .RegWrite   (RegWrite)
    );

endmodule