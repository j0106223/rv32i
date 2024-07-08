`default_nettype none
module store_bytes_decoder(
    addr_offset,
    func3,
    byteenable
);
    input wire [1:0] addr_offset;
    input wire [2:0] func3;
    output reg [3:0] byteenable;
    reg  [3:0] sb_wstrb;
    wire [3:0] sh_wstrb = (addr_offset) ? 4'b1100 : 4'b0011;
    wire sb = (func3 == 3'b000);
    wire sh = (func3 == 3'b001);
    wire sw = (func3 == 3'b010);
    
    assign byteenable = (sw) ? 4'b1111:
                        (sb) ? sb_wstrb:
                        (sh) ? sh_wstrb:
                               4'b0000;

    always @(addr_offset) begin
        case(addr_offset)
            2'b00: sb_wstrb = 4'b0001;
            2'b01: sb_wstrb = 4'b0010;
            2'b10: sb_wstrb = 4'b0100;
            2'b11: sb_wstrb = 4'b1000;
        endcase
    end

endmodule