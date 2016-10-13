nasm -f elf32 kernel.asm -o kernel.o
gcc -m32 -c kernel.c -o myOS.o
ld -m elf_i386 -T link.ld -o kernel kernel.o myOS.o
rm kernel.o myOS.o
qemu-system-i386 -kernel kernel
