CC = riscv32-unknown-elf-gcc
DUMP = riscv32-unknown-elf-objdump
COPY = riscv32-unknown-elf-objcopy
dump.txt:a.elf
	$(DUMP) -D a.elf > dump.txt
	$(COPY) -O verilog a.elf a.hex 
a.elf:main.c start.s linker.ld
	$(CC) -mabi=ilp32 -march=rv32i -S main.s main.c
	$(CC) -mabi=ilp32 -march=rv32i -o a.elf start.s main.s -nostartfiles -Wl,-Bstatic,-T,linker.ld,--strip-debug
.PHONY: clean
clean:
	rm a.elf
clean_all:
	rm a.elf dump.txt main.s a.hex