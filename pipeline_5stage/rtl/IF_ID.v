module IF_ID (
    
);
    input clk;
    input reset_n;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin

        end else begin
        
        end
    end
endmodule