`default_nettype none
module data_memory(
    clk
    address
    read
    write
    rdata
    wdata
);
    parameter AW = 32;
    parameter DW = 32;
    input           clk;
    input  [AW-1:0] address;
    input  [DW-1:0] wdata;
    output [DW-1:0] rdata;
    input           read;
    input           write;

    reg [7:0] mem [0:1024];
    reg [DW-1:0] rdata;
    always @(posedge clk) begin
        if (write) begin
            mem[address]   <= wdata[31:24];
            mem[address+1] <= wdata[23:16];
            mem[address+2] <= wdata[15:8];
            mem[address+3] <= wdata[7:0];
        end
    end

    always @(posedge clk) begin
        if (read) begin
            rdata[31:24] <= mem[address];
            rdata[23:16] <= mem[address+1];
            rdata[15:8]  <= mem[address+2];
            rdata[7:0]   <= mem[address+3];
        end
    end
    
endmodule