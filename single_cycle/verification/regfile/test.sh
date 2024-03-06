#!/usr/bin/bash
iverilog -g2012 ../../rtl/regfile.v tb.sv
#qrun ../../rtl/regfile.v tb.sv
./a.out
rm a.out