`default_nettype none
module regfile (
    clk,
    ra1,
    ra2,
    rd1,
    rd2,
    write,
    wa,
    wd
);

    input  wire          clk;
    input  wire   [4:0]  ra1;        //read1 address
    input  wire   [4:0]  ra2;        //read2 address
    output wire  [31:0]  rd1;        //read1 data
    output wire  [31:0]  rd2;        //read2 data
    input  wire          write;
    input  wire   [4:0]  wa;         //write address
    input  wire  [31:0]  wd;         //write data

    reg [31:0]regiser [1:31];//regiser[0] hard-wire to zero
    assign rd1 = (ra1 == 0) ? 32'h0000_0000 : regiser[ra1];//regiser[0] hard-wired to zero
    assign rd2 = (ra2 == 0) ? 32'h0000_0000 : regiser[ra2];//regiser[0] hard-wired to zero
    
    integer i;
    always @(posedge clk) begin
        if (write && (wa != 0)) begin
            regiser[wa] <= wd;
        end
    end
endmodule