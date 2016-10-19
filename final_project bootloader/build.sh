nasm -f bin boot.asm -o boot.bin
#nasm kernelentry.asm -f elf -o kernelentry.o
gcc -ffreestanding -c ./kernel/kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
cat boot.bin kernel.bin >OS_Image
rm boot.bin kernel.bin kernel.o
qemu-system-i386 -fda OS_Image
rm OS_Image
#TO SHOW THE HEX IMAGE OF THE OS_Image RUN "od -t x1 -A n OS_Image"
