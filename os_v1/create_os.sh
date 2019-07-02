#!/bin/sh

if [ -d tmp ]
then
	rm -r tmp
fi

mkdir tmp
mkdir -p iso/boot/grub

nasm -f elf32 src/loader.s -o tmp/loader.o
ld -T src/link.ld -melf_i386 tmp/loader.o -o tmp/kernel.elf

cp grub/stage2_eltorito iso/boot/grub/   # copy the bootloader
cp grub/menu.lst       iso/boot/grub    #copy bootloader configuration
cp tmp/kernel.elf iso/boot/             # copy the kernel

genisoimage -R  -b boot/grub/stage2_eltorito  -no-emul-boot  -boot-load-size 4  -A iso -input-charset utf-8 -quiet  -boot-info-table   -o minimal_os.iso iso
