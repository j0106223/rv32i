`default_nettype none
module rv32_single_cycle_top (
    clk,
    reset_n
);

    //instruction master
    //data master
    parameter AW = 32;
    parameter DW = 32;
    parameter DATA_MEMORY_BASE = 'h1000;
    parameter DATA_MEMORY_SIZE = 1024;
    input clk;
    input reset_n;

    wire [31:0]   pc;
    wire [31:0]   instruction;
    wire [AW-1:0] address;
    wire          MemRead;
    wire          MemWrite;
    wire [DW-1:0] rdata;
    wire [DW-1:0] wdata;

    rv32_single_cycle_core rv32_single_cycle_core (
        .clk        (clk),
        .reset_n    (reset_n),
        .instruction(instruction),
        .address    (address),
        .MemRead    (MemRead),
        .MemWrite   (MemWrite),
        .wdata      (wdata),
        .rdata      (rdata),
        .pc         (pc)
    );

    instruction_memory instruction_memory(
        .address (pc),
        .data    (instruction)
    );

    data_memory #(
        .BASE       (DATA_MEMORY_BASE),
        .SIZE       (DATA_MEMORY_SIZE)
    )data_memory(
        .clk        (clk),
        .address    (address),
        .read       (MemRead),
        .write      (MemWrite),
        .rdata      (rdata),
        .wdata      (wdata)
    );



    
endmodule