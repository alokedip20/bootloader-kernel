nasm -f bin boot.asm -o boot.bin
#nasm kernelentry.asm -f elf -o kernelentry.o
gcc -ffreestanding -c ./kernel/kernel.c -o kernel.o -m32
ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary -melf_i386
cat boot.bin kernel.bin >OS_Image
qemu-system-i386 OS_Image
rm OS_Image boot.bin kernel.bin kernel.o
#TO SHOW THE HEX IMAGE OF THE OS_Image RUN "od -t x1 -A n OS_Image"
