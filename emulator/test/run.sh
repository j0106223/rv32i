#gen test program elf
make clean
make
################################################
#gen model elf without debug message
cd ..
cd src/
make debug_off
cd ..
cd test
../src/./rv32i_emulator a.hex > output.log

################################################
#gen model elf with debug message
cd ..
cd src/
make debug_on
cd ..
cd test
../src/./rv32i_emulator a.hex > debug.log