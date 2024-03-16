#!/usr/bin/bash
make
make clean
qrun ../../rtl/control.v tb.sv
iverilog -g2012 -o control.vvp ../../rtl/control.v tb.sv
./control.vvp | tee irun.log
rm control.vvp