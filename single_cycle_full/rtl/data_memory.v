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
    
    input  wire          clk;
    input  wire [AW-1:0] address;
    input  wire [DW-1:0] wdata;
    output wire [DW-1:0] rdata;
    input  wire          read;
    input  wire          write;

    reg [7:0] mem [BASE:(BASE + SIZE)];
    always @(posedge clk) begin
        if (write) begin
            mem[address+3] <= wdata[31:24];
            mem[address+2] <= wdata[23:16];
            mem[address+1] <= wdata[15:8];
            mem[address]   <= wdata[7:0];
        end
    end

    assign rdata[31:24] = (read) ? mem[address+3] : {DW{1'bx}};
    assign rdata[23:16] = (read) ? mem[address+2] : {DW{1'bx}};
    assign rdata[15:8]  = (read) ? mem[address+1] : {DW{1'bx}};
    assign rdata[7:0]   = (read) ? mem[address]   : {DW{1'bx}};

    initial begin // initiate data memory
        $readmemh("data.hex", mem);
    end
endmodule