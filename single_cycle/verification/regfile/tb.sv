`timescale 1ns/1ps
module tb;
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
    end
    reg        clk;
    reg        write;
    reg  [4:0] wa;
    reg [31:0] wd;
    reg [4:0] ra1;
    reg [4:0] ra2;
    wire [31:0] rd1;
    wire [31:0] rd2;
    bit [31:0] reg_wdata[0:31];
    reg [31:0] reg_rdata[0:31]; 
    
    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;    
        end
    end
    initial begin
        for (int i = 0;i < 10; i++) begin
            $display("round %0d", i);
            test_reg();
        end
        $finish;
    end

    regfile regfile(
        .clk    (clk),
        .ra1    (ra1),
        .ra2    (ra2),
        .rd1    (rd1),
        .rd2    (rd2),
        .write  (write),
        .wa     (wa),
        .wd     (wd)
);
    task test_reg;
        begin
            bit [31:0] data;
            for (int i = 0; i < 32; i++) begin
                reg_wdata[i] = $random;
                write_reg(i, reg_wdata[i]);
                read_reg(i, {$random} % 2);
                if (i == 0) begin
                    if (reg_rdata[i] != 0) begin
                        $display("reg[0] should be hard-wried zero!!");
                        $finish;
                    end
                end else begin
                    if (reg_rdata[i] != reg_wdata[i]) begin
                        $display("%0t: reg[%0d] = %0d write value = %0x", $realtime, i, data, reg_wdata[i]);
                        $finish;
                    end
                end
            end
            $display("test_reg pass!!");
        end
    endtask
    task write_reg(bit [4:0] address, bit [31:0] data);
        begin
            @(posedge clk);
            write = 1'b1;
            wa    = address;
            wd    = data;
            @(posedge clk);
            write = 1'b0;
            wa    = 0;
            wd    = 0;
        end
    endtask

    task read_reg(bit [4:0] address, int port);
        begin
            if (port == 0) begin
                @(posedge clk);
                ra1   = address;
                @(posedge clk);
                ra1   = 0;
                reg_rdata[address] = rd1;
            end else begin
                @(posedge clk);
                ra2   = address;
                @(posedge clk);
                ra2   = 0;
                reg_rdata[address] = rd2;
            end
        end
    endtask
endmodule