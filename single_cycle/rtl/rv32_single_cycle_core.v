module rv32_single_cycle_core (
    clk,
    reset_n,
    address,
    mem_read,
    mem_write,
    write_data,
    read_data,
    data,
    instruction,
    pc,
);
    parameter [31:0] RESET_VECTOR = 32h'0000_0000;
    parameter AW = 32;
    parameter DW = 32;

    input           clk;
    input           reset_n;
    output [AW-1:0] address;
    output          mem_read;
    output          mem_write;
    output [DW-1:0] write_data;
    input  [DW-1:0] read_data;
    output   [31:0] pc;

    wire   pc_nx;
    assign pc_nx = (branch && zero) ? pc+4 : pc+offset;
    reg [31:0] pc;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            pc <= RESET_VECTOR;
        end else begin
            pc <= pc_nx;
        end
    end
endmodule