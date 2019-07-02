#!/bin/sh


nasm -f elf32 src/loader.s -o out/loader.o

ld -T src/link.ld -melf_i386 out/loader.o -o out/kernel.elf


mkdir -p iso/boot/grub              # create the folder structure 
cp grub/stage2_eltorito iso/boot/grub/   # copy the bootloader
cp grub/menu.lst       iso/boot/grub    #copy bootloader configuration
cp out/kernel.elf iso/boot/             # copy the kernel

genisoimage -R  -b boot/grub/stage2_eltorito  -no-emul-boot  -boot-load-size 4  -A iso -input-charset utf-8 -quiet  -boot-info-table   -o minimal_os.iso iso
