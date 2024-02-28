module rv32_single_cycle_top (
    clk,
    reset_n
);

    //instruction master
    //data master
    rv32_single_cycle_core rv32_single_cycle_core(
        .clk        (clk),
        .reset_n    (reset_n),
        .address,
        .read,
        .write,
        .wdata,
        .rdata,
        .instruction,
        .pc
    );
    instruction_memory instruction_memory(
        address,
        data
    );

    data_memory data_memory(
        .clk(clk)
        .address
        .read
        .write
        .rdata
        .wdata
    );

    regfile regfile(
        .clk(clk)
        ra1,        //read1 address
        ra2,        //read2 address
        rd1,        //read1 data
        rd2,        //read2 data
        write,
        wa,         //write address
        wd          //write data
    );

    
endmodule