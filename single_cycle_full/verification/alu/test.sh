#!/usr/bin/bash
make
make clean
# qrun ../../rtl/alu.v tb.sv
iverilog -g2012 -o alu.vvp ../../rtl/alu.v tb.sv
./alu.vvp | tee irun.log
rm alu.vvp