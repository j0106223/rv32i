`timescale 1ns/1ps
module tb;
    
    localparam AND  = 4'b0000;
    localparam OR   = 4'b0001;
    localparam ADD  = 4'b0010;
    localparam SUB  = 4'b0110;
    int fp;
    int seed;

    bit[3:0]    op;
    bit  [31:0] data1;
    bit  [31:0] data2;
    wire [31:0] result;
    wire        zero;
    
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
    end
    initial begin
        for (int i = 0;i < 100; i++) begin
            $display("================================round %0d================================", i);
            repeat(100) begin
                alu_test();
            end
        end
        $finish;
    end

    alu alu(
        .ALU_Operation  (op),
        .Data1          (data1),
        .Data2          (data2),
        .ALU_result     (result),
        .ZERO           (zero)
    );

task alu_test;
    begin
        int test_case;
        test_case = {$random(seed)} % 4;
        case(test_case)
            0: begin op = AND; and_test(); end
            1: begin op = OR;  or_test();  end
            2: begin op = ADD; add_test(); end
            3: begin op = SUB; sub_test(); end
            default: begin $display("not supported test case"); $finish; end
        endcase
    end
endtask

task  and_test;
    begin
        bit [31:0] expect_result; 
        data1 = {$random(seed)};
        data2 = {$random(seed)};
        expect_result = data1 & data2; 
        #1;
        if (result != expect_result) begin
            $display("and_test fail!!");
            $display("data1:%0x", data1);
            $display("data2:%0x", data2);
            $display("expect result:%0x", expect_result);
            $display("result:%0x", result);
            $finish;
        end
        if ((data1 == data2) && (zero != 1)) begin
            $display("ZERO fail!!");
            $display("ZERO should assert when data1 == data2");
            $finish;
        end
        $display("and_test pass!!");
    end
endtask

task  or_test;
    begin
        bit [31:0] expect_result;
        data1 = {$random(seed)};
        data2 = {$random(seed)};
        expect_result = data1 | data2; 
        #1;
        if (result != expect_result) begin
            $display("and_test fail!!");
            $display("data1:%0x",data1);
            $display("data2:%0x",data2);
            $display("expect result:%0x",expect_result);
            $display("result:%0x",result);
            $finish;
        end
        if ((data1 == data2) && (zero != 1)) begin
            $display("ZERO fail!!");
            $display("ZERO should assert when data1 == data2");
            $finish;
        end
        $display("or_test pass!!");
    end
endtask

task  add_test;
    begin
        bit [31:0] expect_result;
        data1 = {$random(seed)};
        data2 = {$random(seed)};
        expect_result = data1 + data2; 
        #1;
        if (result != expect_result) begin
            $display("and_test fail!!");
            $display("data1: %0x", data1);
            $display("data2: %0x", data2);
            $display("expect result: %0x", expect_result);
            $display("result: %0x", result);
            $finish;
        end
        if ((data1 == data2) && (zero != 1)) begin
            $display("ZERO fail!!");
            $display("ZERO should assert when data1 == data2");
            $finish;
        end
        $display("add_test pass!!");
    end
endtask

task  sub_test;
    begin
        bit [31:0] expect_result;
        data1 = {$random(seed)};
        data2 = {$random(seed)};
        expect_result = data1 - data2; 
        #1;
        if (result != expect_result) begin
            $display("sub_test fail!!");
            $display("data1:%0x",data1);
            $display("data2:%0x",data2);
            $display("expect:%0x",data1 - data2);
            $display("result:%0x",result);
            $finish;
        end

        if ((data1 == data2) && (zero != 1)) begin
            $display("ZERO fail!!");
            $display("ZERO should assert when data1 == data2");
            $finish;
        end
        $display("sub_test pass!!");
    end
endtask
endmodule