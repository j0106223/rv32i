cd Assembly
make
make clean
cp a.hex  ../
cd ..
iverilog -g2012 -o tb.vvp tb.sv ../../rtl/*.v
./tb.vvp
rm tb.vvp