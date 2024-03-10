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
        #1000;
        $finish;
    end
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[1]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[2]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[3]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[4]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[5]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[6]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[7]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[8]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[9]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[10]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[11]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[12]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[13]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[14]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[15]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[16]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[17]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[18]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[19]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[20]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[21]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[22]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[23]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[24]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[25]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[26]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[27]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[28]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[29]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[30]);
        $dumpvars(1, rv32_single_cycle_top.rv32_single_cycle_core.regfile.regiser[31]);
    end

    
    initial begin
        $monitor("%0t: pc = 0x%0x", $realtime, rv32_single_cycle_top.pc);
    end
    initial begin
        #1;
        show_data_memory();
        #800;
        show_data_memory();
        
    end
    rv32_single_cycle_top rv32_single_cycle_top(
        .clk     (clk),
        .reset_n (reset_n)
    );
    task show_data_memory;
        for (int i = 0; i < 1024; i++) begin
            if(((i + 1) % 16 == 0) && (i != 0))begin
                $display("%02x",rv32_single_cycle_top.data_memory.mem[1024+i]);
            end else begin
                $write("%02x ",rv32_single_cycle_top.data_memory.mem[1024+i]);
            end
        end
        $display(" ");
    endtask
endmodule