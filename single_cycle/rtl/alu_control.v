module ALU_control (
    instruction_funct3,
    instruction_funct7,
    ALUOp,
    ALU_Operation
);
    localparam AND = 4'b0000;
    localparam OR  = 4'b0001;
    localparam ADD = 4'b0010;
    localparam SUB = 4'b0110;

    input   [2:0]   instruction_funct3;
    input           instruction_funct7;//just only needs take instruction[30],funct7[6]
    input   [1:0]   ALUOp;
    output  [3:0]   ALU_Operation;


    reg  [3:0] control;
    wire       funct7;
    wire [2:0] funct3;
    wire       beq;
    wire       R_type;

    assign funct3 = instruction_funct3;
    assign funct7 = instruction_funct7;//for sub
    assign beq    = ALUOp[0];
    assign R_type = ALUOp[1];
    assign ALU_Operation = control;
    
    
    always @* begin
        if (R_type) begin
            case({funct7, funct3})
                4'b0111: control = AND;
                4'b0001: control = OR;
                4'b0000: control = ADD;
                4'b0110: control = SUB;
                default: control = 4'bxxxx;
            endcase
        end else begin
            if (beq) begin
                control = SUB;
            end else begin //load store
                control = ADD;
            end
        end
    end

endmodule