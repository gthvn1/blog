---
title: "Good bye real mode"
categories:
  - Blog
tags:
  - bootloader
---

## We are in Real Mode

### Addresses
When you boot you are in real mode. In this mode the physical address is on
20 bits. As we are using 16 from registers the address is computed by
shifting the segment value by 4 bits on the left and adding the offset.
For example the address CS:AX where CS is equal to 0x1234 and AX is equal
to 0x5678 is in fact 0x12340 + 0x5678 = 0x179B8.

