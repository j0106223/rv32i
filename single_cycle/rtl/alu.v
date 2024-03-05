`default_nettype none
module ALU (
    ALU_Operation,
    Data1,
    Data2,
    ALU_result,
    ZERO
);

    input   [3:0]   ALU_Operation;
    input   [31:0]  Data1;
    input   [31:0]  Data2;
    output  [31:0]  ALU_result;
    output          ZERO;


    localparam AND  = 4'b0000;
    localparam OR   = 4'b0001;
    localparam ADD  = 4'b0010;
    localparam SUB  = 4'b0110;
    
    reg     [31:0]  result;
    assign ZERO = ~|result;//Self bitwise
    assign ALU_result = result;
    

    always @* begin
        case(ALU_Operation)
            AND:result = Data1 & Data2;
            OR :result = Data1 | Data2;
            ADD:result = Data1 + Data2;
            SUB:result = Data1 - Data2;
        endcase
    end
        
endmodule