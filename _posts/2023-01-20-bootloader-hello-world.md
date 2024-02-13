---
title: "Hello from bootloader"
categories:
  - Blog
tags:
  - bootloader
  - assembly
---

## The Hello World bootloader

  When your computer starts the first step is to load the BIOS from the ROM. It will do the
initialization of hardware and it will try to find a place like a disk where a piece of code
called the bootloader is stored. It only looks the first 512 bytes of the device. If the BIOS
finds a bootloader that is recognized with its magic number stored on the last two bytes of
the 512 bytes it loads it at a known address (0x7C00) and the bootloader is executed. This piece
of software is called the fist stage bootloader.

You will find the classical
[hello world bootloader](https://github.com/gthvn1/yet-another-kernel/blob/babystep2/babysteps/boot.asm)
To build it you will need a compiler like **nasm**. The following command can be used:
- `nasm boot.asm -f bin -o boot.bin`

This will generate a binary file that can be used as a boot device. In the first 512 bytes there
is the boot loader. It is usable under qemu:
- `qemu-system-i386 -drive format=raw,file=boot.bin`

### Some debug

You can start qemu with gdb enabled and stopped on the first instruction:
- `qemu-system-i386 -s -S -drive format=raw,file=boot.bin`
This will start qemu and stop it at startup. The **-s** option enable a gdb connection.
Once started and stopped you can use gdb to connect remotly. From another terminal:

```sh
# gdb -ex 'target remote localhost:1234' \
      -ex 'set architecture i8086' \
      -ex 'set disassembly-flavor intel' \
      -ex 'break *0x7C00' \
      -ex 'continue'

Breakpoint 1, 0x00007c00 in ?? ()
(gdb) x/10i $pc
=> 0x7c00:	cli
   0x7c01:	mov    esi,0xeb47c10
   0x7c06:	lods   al,BYTE PTR ds:[esi]
   0x7c07:	or     al,al
   0x7c09:	je     0x7c0f
   0x7c0b:	int    0x10
   0x7c0d:	jmp    0x7c06
   0x7c0f:	hlt
   0x7c10:	dec    eax
   0x7c11:	gs ins BYTE PTR es:[edi],dx
(gdb) x/s 0x7c10
0x7c10:	"Hello, World!"
(gdb) c
```
And from here you can *stepi*, display registers and just enjoy... Note the break at 0x7C00. As said
previously it is the BIOS that loads the code here. Also notice that after the **hlt** instruction it
is our string **msg**...

