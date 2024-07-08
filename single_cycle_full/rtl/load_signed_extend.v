`default_nettype none
module load_signed_extend(
    func3
    mem_rdata
    load_data
);
    input wire [2:0] func3;
    input wire[31:0] mem_rdata;
    output reg [31:0] load_data;
    always @* begin
        case(func3)
            3'b000: load_data = {24{mem_rdata[31]}, mem_rdata[7:0]};  //LB
            3'b001: load_data = {15{mem_rdata[31]}, mem_rdata[15:0]}; //LH
            3'b010: load_data =                     mem_rdata;        //LW 
            3'b100: load_data = {         24{1'b0}, mem_rdata[7:0]};  //LBU
            3'b101: load_data = {         15{1'b0}, mem_rdata[15:0]}; //LHU
            default:load_data = 32'b0;
        endcase
    end
endmodule