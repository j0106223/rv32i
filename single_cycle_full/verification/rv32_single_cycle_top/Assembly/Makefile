CC = riscv64-unknown-elf-gcc
DUMP = riscv64-unknown-elf-objdump
COPY = riscv64-unknown-elf-objcopy
dump.txt:a.elf
	$(DUMP) -D a.elf > dump.txt
	$(COPY) -O verilog a.elf a.hex
a.elf:start.s linker.ld
	$(CC) -mabi=ilp32 -march=rv32i -o a.elf start.s ./load_store_test/load_store_test.s -nostartfiles -Wl,-Bstatic,-T,linker.ld,--strip-debug
.PHONY: clean
clean:
	rm a.elf
clean_all:
	rm a.elf dump.txt a.hex