`timescale 1ns/1ps
module tb;
    parameter AW = 32;
    parameter DW = 32;

    reg        clk;
    reg  [AW-1:0]  address;
    reg  [DW-1:0]  wdata;
    reg            read;
    reg            write;

    wire [DW-1:0]  rdata;

    int fp;
    int seed;
    /*
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
    end
    */
    initial begin
        fp = $fopen("seed.txt","r");
        $fscanf(fp, "%d", seed);
        $display("seed = %d", seed);
        $fclose(fp);
    end
    initial begin
        clk = 0;
        forever begin
            #1 clk = ~clk;    
        end
    end
    initial begin
        repeat(10) begin
            test_data_memory();
        end
        $finish;
    end

    data_memory #( 
        .BASE(0)
    )data_memory(
        .clk     (clk),
        .address (address),
        .read    (read),
        .write   (write),
        .rdata   (rdata),
        .wdata   (wdata)
    );

    task test_data_memory;
        begin
            reg [DW-1:0] out;
            reg [DW-1:0] temp;
            reg [AW-1:0] addr;
            
            temp = {$random(seed)}%10;
            addr = {$random(seed)}%1024;

            write_data(addr, temp);
            read_data(addr, out);
            
            if(out == temp) begin
                $display("%t pass, %d: %d, %d",$time, addr, temp, out);
            end else begin
                $display("%t failed, %d: %d, %d",$time, addr, temp, out);
            end
        end
    endtask
    task write_data(bit [AW-1:0] addr, bit [DW-1:0] data);
        begin
            @(posedge clk);
            write = 1'b1;
            address    = addr;
            wdata    = data;
            @(posedge clk);
            write = 1'b0;
            address    = 0;
            wdata    = 0;
        end
    endtask

    task read_data(bit [AW-1:0] addr, output [DW-1:0] read_data);
        begin
            @(posedge clk);
            read = 1;
            address  = addr;
            @(posedge clk);
            read = 0;
            read_data = rdata;
        
        end
    endtask
endmodule