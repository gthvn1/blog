---
title: "Your door to operating system"
categories:
  - Blog
tags:
  - bootloader
---

# A new world

In the [previous post](https://gthvn1.github.io/blog/posts/bootloader-good-bye-real-mode/)
we saw how a boot loader switches from real to protected mode and had access to a 32 bits
address space. Before reaching the entry point of the operating system it needs to be able
to read the boot device, find a piece of code that matches some requirements, load it and
jump to an entry point.

We won't go deeper but we will see what is needed to boot the
[Hello world OS](https://github.com/gthvn1/yet-another-kernel/blob/main/from_grub/boot.asm)
using the well known **grub** bootloader.

## Multiboot header

As said in the introduction the bootloader goal is to find an OS image on a boot device
and then setup things to execute it. The problem is that there is a lot of possible
file format and each operating system has its own. To be *OS* agnostic **grub**
introduces the *Multiboot header* so it can loads image without knowing all of this
formats.

Here is the multiboot header file for our *OS*:
- [multiboot header](https://github.com/gthvn1/yet-another-kernel/blob/main/from_grub/multiboot_header.asm)

We are following the magic fields for [multiboot2 header](https://www.gnu.org/software/grub/manual/multiboot2/multiboot.html).

## The linker

So we have some asm code that contains the multiboot header for *grub*, we have another
assembly code that has an entry point for our *OS* and print `Hello, World!` before
halting but how to generate a bootable kernel. We need to use a
[linker script](https://github.com/gthvn1/yet-another-kernel/blob/main/from_grub/linker.ld)
to tell to the linker where things need to be put.

- First we set the entry point *start*. It is the first instruction to execute. In our case it
is the name of our function in
[boot.asm](https://github.com/gthvn1/yet-another-kernel/blob/main/from_grub/boot.asm)

- Then we use **SECTIONS**. Sections are describing the memory layout of the output file.
  Here we tell to the linker that our first section is the *boot* section and it will be mapped
  at 0x100000. This address is the for the kernel in protected-mode. Below this address are
  memory reserved for BIOS, for the bootloader and other things. So we need to tell to the linker
  to start at 0x100000. For now it is pretty simple. We have the mulitboot section and on top
  of it we will have the "Hello world kernel".

After building the kernel you can list the symbols from *kernel.bin* and check that addresses
are set as expected:

```
# nm -s iso/boot/kernel.bin
0000000000100000 R boot
0000000000100000 r header
0000000000100018 r header.end
0000000000100000 r header.start
0000000000100000 A phys
0000000000100020 T start
0000000000100020 T text

```

## Generating the ISO image

To generate an image understandable by *grub* the easiest way is to generate a
rescue image using *grub-mkrescue*. It will generate a bootable ISO image.

## some links

- [Linkder ld](https://sourceware.org/binutils/docs-2.40/ld.html)
- [Grub bootable CD](https://www.gnu.org/software/grub/manual/grub/html_node/Making-a-GRUB-bootable-CD_002dROM.html#Making-a-GRUB-bootable-CD_002dROM)
- [OSDev multiboot](https://wiki.osdev.org/Multiboot)
- [grub multiboot](https://www.gnu.org/software/grub/manual/multiboot/multiboot.html)
- [Linux insides (0xAX)](https://0xax.gitbooks.io/linux-insides/content/Booting/linux-bootstrap-1.html)
