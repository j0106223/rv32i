#gen test program elf
make clean
make
################################################
#gen model elf without debug message
cd ../../
cd src/
gcc -o rv32i_emulator main.c cpu.c loader.c -I/home/jj/Documents/rv32i/emulator/inc
cd ..
cd test
cd sorting
../../src/./rv32i_emulator a.hex > output.log

################################################
#gen model elf with debug message
cd ../../
cd src/
gcc -o rv32i_emulator main.c cpu.c loader.c -DDEBUG -I/home/jj/Documents/rv32i/emulator/inc
cd ..
cd test
cd sorting
../../src/./rv32i_emulator a.hex > debug.log