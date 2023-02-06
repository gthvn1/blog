---
title: "Enter long mode"
categories:
  - Blog
tags:
  - bootloader
  - zig
---

## Welcome to kernel space

In the [previous post](https://gthvn1.github.io/blog/posts/bootloader-good-bye-real-mode/)
we see quickly that the grub bootloader that has started in real mode configured the
hardware to run in protected mode and loaded our *operating system* in memory and jump to
its entry. So at this point we are running on 32 bits. The next step is to enable paging
to be able to run long mode.

After looking different sites on the internet we found some interesting stuff around
[zig](https://ziglang.org/). One thing that caught my eyes was the *freestanding*
implementation. It provides the ability to directly run on hardware, remove the
need of the standard library, defined the entry point of your program, etc...
In a post from Andrew Kelley called [Using Zig to Provide Stack Traces on Kernel Panic
for a Bare Bones Operating System](https://andrewkelley.me/post/zig-stack-traces-kernel-panic-bare-bones-os.html)
he explains that with *Zig* we have the possibility to create our
own panic handler. It could be cool to add that in the early steps of the developpement
of our kernel to see what happens.

To play with *zig* we followed the [Bare Bones tutorial](https://wiki.osdev.org/Bare_Bones)
but instead of writing it in *C* we will wrote it in *Zig*. And we should not be stuck because
it already exists... see links below.

So the first steps was to be able to boot our tiny little thing that can hardly be called
an operating system [ZigOS](https://github.com/gthvn1/yet-another-kernel/tree/master/zigos)
from grub. We already do that in assembly. Then we write the banner to the screen. Once done
the next really cool new stuff will be the setup of the long mode (*IDT*, *paging*,...).
Code is avalaible on [ZigOS](https://github.com/gthvn1/yet-another-kernel/tree/master/zigos)
and we only update the [Readme file](https://github.com/gthvn1/yet-another-kernel/blob/master/zigos/Readme.md).
But for specific parts like setting the interrupts, the page table, the panic handler, etc...
we will post a dedicated blog...

## Links

- [OSdev - Zig bare bones](https://wiki.osdev.org/Zig_Bare_Bones)
- [Pluto - a simple operating system](https://github.com/ZystemOS/pluto)
- [Zen - experimental operating system](https://github.com/AndreaOrru/zen)
