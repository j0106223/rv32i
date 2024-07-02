`default_nettype none
module alu (
    ALU_Operation,
    Data1,
    Data2,
    ALU_result,
    ZERO
);

    input  wire [3:0]   ALU_Operation;
    input  wire [31:0]  Data1;
    input  wire [31:0]  Data2;
    output wire [31:0]  ALU_result;
    output wire         ZERO;

    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam SLL  = 4'b0010;
    localparam SLT  = 4'b0011;
    localparam SLTU = 4'b0100;
    localparam XOR  = 4'b0101;
    localparam SRL  = 4'b0110;
    localparam SRA  = 4'b0111;
    localparam OR   = 4'b1000;
    localparam AND  = 4'b1001;

    reg     [31:0]  result;
    assign ZERO = ~|result;//Self bitwise
    assign ALU_result = result;
    

    always @* begin
        case(ALU_Operation)
            ADD :result = Data1 + Data2;
            SUB :result = Data1 - Data2;
            SLL :result = Data1 << Data2[4:0];
            SLT :begin
                    if(Data1[31] ^ Data2[31])begin
                        result = (Data2[31]) ? 1'b1 : 1'b0;
                    end else begin
                        result = (Data1 < Data2);       
                    end
            end
            SLTU:result = (Data1 < Data2);
            XOR :result = Data1 ^ Data2;
            SRL :result = Data1 >> Data2[4:0];
            SRA :result = Data1 >>> Data2[4:0];
            OR  :result = Data1 | Data2;
            AND :result = Data1 & Data2;
            default result = 32'hxxxx_xxxx;
        endcase
    end
        
endmodule