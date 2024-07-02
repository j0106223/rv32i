#!/usr/bin/bash
make
make clean
# qrun ../../rtl/regfile.v tb.sv
iverilog -g2012 -o data_memory.vvp ../../rtl/data_memory.v tb.sv
./data_memory.vvp | tee irun.log
rm data_memory.vvp