`default_nettype none
module instruction_memory (
    address,
    data
);
    parameter AW = 32;
    parameter DW = 32;

    input  wire [AW-1:0] address;
    output wire [DW-1:0] data;

    reg [7:0] mem [0:1024];

    initial begin
        $readmemh("../Assembly/a.hex",mem);
    end

    assign data[31:24] = mem[address+3]; 
    assign data[23:16] = mem[address+2];
    assign data[15:8]  = mem[address+1];
    assign data[7:0]   = mem[address];
endmodule