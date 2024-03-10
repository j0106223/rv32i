cd Assembly
make
make clean
cp a.hex  ../
cd ..
qrun tb.sv ../../rtl/*.v
iverilog -g2012 -o tb.vvp tb.sv ../../rtl/*.v
./tb.vvp
rm tb.vvp