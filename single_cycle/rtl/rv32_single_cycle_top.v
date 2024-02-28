module rv32_single_cycle_top (
    clk,
    reset_n
);

    //instruction master
    //data master
    parameter AW = 32;
    parameter DW = 32;
    wire [31:0]   pc;
    wire [31:0]   instruction;
    wire [AW-1:0] address;
    wire          MemRead;
    wire          MemWrite;
    wire [DW-1:0] c;
    wire [DW-1:0] rdata;

    rv32_single_cycle_core rv32_single_cycle_core (
        .clk(clk),
        .reset_n(reset_n),
        .instruction(instruction),
        .address(address),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .wdata(wdata),
        .rdata(rdata),
        .pc(pc)
    );

    instruction_memory instruction_memory(
        address(pc),
        data(instruction)
    );

    data_memory data_memory(
        .clk(clk),
        .address(address),
        .read(MemRead),
        .write(MemWrite),
        .rdata(rdata),
        .wdata(wdata)
    );



    
endmodule