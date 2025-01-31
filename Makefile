main.elf compile: m.s m.ld
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld m.s -o main.elf

start_qemu: main.elf
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel main.elf -gdb tcp::1234

connect_gdb: main.elf
	gdb-multiarch main.elf -ex "target remote localhost:1234" -ex "break _start" -ex "continue" -q

print_binary: main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin
	xxd -e -c 4 -g 4 main.bin

clean:
	rm -rf *.out *.bin *.elf