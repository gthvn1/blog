---
title: "Good bye real mode"
categories:
  - Blog
tags:
  - bootloader
---

# We are in Real Mode

## Addresses

When you boot you are in real mode. In this mode the physical address is on
20 bits. As we are using 16 from registers the address is computed by
shifting the segment value by 4 bits on the left and adding the offset.
For example the address CS:AX where CS is equal to 0x1234 and AX is equal
to 0x5678 is in fact 0x12340 + 0x5678 = 0x179B8.

## To protected mode

In real mode it is easy to access BIOS functions. But the 20 bits address space
is limiting. So the goal in real mode is to swtich to protected mode. Before
switching to proteced mode we need to setup several things.

Address in protected mode are not computed like in real mode. It requires the
setup of the **G**lobal **D**escriptor **T**able (aka GDT). The segment is used
as an index into the **GDT**.

### GDT

It is a table. Each entry is on 8 bytes (64 bits).
An entry can refer to four different things. It can refer to:
- a segment descriptor
- a task state segment (TSS)
- a local descriptor table (LDT)
- a call gate

Before switching to protected mode we need to add an segment descriptor for the
code and another one for the data.

