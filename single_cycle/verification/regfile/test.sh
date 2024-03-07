#!/usr/bin/bash
make
make clean
qrun ../../rtl/regfile.v tb.sv
iverilog -g2012 -o regfile.vvp ../../rtl/regfile.v tb.sv
./regfile.vvp | tee irun.log
rm regfile.vvp