cd ..
cd src/
gcc -o rv32i_emulator main.c cpu.c loader.c -I/home/jj/Documents/rv32i/emulator/inc
cd ..
cd test
../src/./rv32i_emulator a.hex > tmp.txt