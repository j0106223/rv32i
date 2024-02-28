module rv32_single_cycle_core (
    clk,
    reset_n,
    address,
    data,
);
    parameter [31:0] RESET_VECTOR = 32h'0000_0000;
    input clk;
    input reset_n;

    wire pc_nx;
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