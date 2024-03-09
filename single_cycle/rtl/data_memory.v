`default_nettype none
module data_memory(
    clk,
    address,
    read,
    write,
    rdata,
    wdata
);
    parameter AW = 32;
    parameter DW = 32;
    parameter BASE = 'h1000;
    parameter SIZE = 1024; //byte
    input           clk;
    input  [AW-1:0] address;
    input  [DW-1:0] wdata;
    output [DW-1:0] rdata;
    input           read;
    input           write;

    reg [7:0] mem [BASE:(BASE + SIZE)];
    reg [DW-1:0] rdata;
    always @(posedge clk) begin
        if (write) begin
            mem[address+3] <= wdata[31:24];
            mem[address+2] <= wdata[23:16];
            mem[address+1] <= wdata[15:8];
            mem[address]   <= wdata[7:0];
        end
    end

    always @(posedge clk) begin
        if (read) begin
            rdata[31:24] <= mem[address+3];
            rdata[23:16] <= mem[address+2];
            rdata[15:8]  <= mem[address+1];
            rdata[7:0]   <= mem[address];
        end
    end
    
endmodule