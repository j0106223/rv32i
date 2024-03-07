`timescale 1ns/1ps
module tb;
    reg clk;
    reg reset_n;
    initial begin
        clk = 1'b0;
        forever begin
            #1 clk = ~clk;    
        end
    end

    initial begin
        reset_n = 1'b0;
        @(negedge clk);
        reset_n = 1'b1;
    end
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end
    initial begin
        /*
        forever begin
            @(posedge clk);
            if (DUT.pc == 7777) begin
                $finish;
            end
        end*/
        #10000;
        $finish;
    end
    always @(posedge clk) begin
        $display("pc = %0d",DUT.pc);
    end
    rv32_single_cycle_top DUT(
        .clk     (clk),
        .reset_n (reset_n)
    );
endmodule