nasm -f bin boot_sect.asm -o boot_sect.bin
gcc -ffreestanding -c kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
cat boot_sect.bin kernel.bin >OS_Image
rm boot_sect.bin kernel.bin kernel.o
qemu-system-i386 -fda OS_Image

#TO SHOW THE HEX IMAGE OF THE OS_Image RUN "od -t x1 -A n OS_Image"
