---
title: "Enter long mode"
categories:
  - Blog
tags:
  - bootloader
---

## Welcome to kernel space

In the [previous post](https://gthvn1.github.io/blog/posts/bootloader-good-bye-real-mode/)
we see quickly that the grub bootloader that has started in real mode configured the 
hardware to run in protected mode and loaded our *operating system* in memory and jump to
its entry. So at this point we are running on 32 bits. The next step is to enable paging
to be able to run long mode. Enabling paging means setup the page table

## Links

[OSdev - Zig bare bones](https://wiki.osdev.org/Zig_Bare_Bones)
[Pluto - a simple operating system](https://github.com/ZystemOS/pluto)
[Zen - experimental operating system](https://github.com/AndreaOrru/zen)
