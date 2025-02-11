+++
title = "Mirageos Part1"
date = "2025-02-11T11:36:00+01:00"
#dateFormat = "2006-01-02" # This value can be configured for per-post date formatting
author = ""
authorTwitter = "" #do not include @
cover = ""
tags = ["ocaml", "unikernel", "mirageos"]
keywords = ["", ""]
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Here is my view about the stack used by [MirageOS](https://github.com/mirage):

1. **Hypervisor Layer (e.g., KVM):**  
   - At the very bottom, we have an hypervisor. When using KVM, the Linux kernel's KVM module
   provides virtualization support (managing things like VM exits and entries).

2. **Solo5:**  
   - Solo5 sits just above the hypervisor. It's a minimal execution environment (or "unikernel
   monitor") that abstracts hypervisor details.
   - It provides a simple API (often implemented using ioctls in the KVM case) for handling I/O
   and other operations required by the unikernel, without all the overhead of a full OS.

3. **ocaml-solo5:**  
   - This is a port of the OCaml runtime to run on top of Solo5.  
   - It's a very stripped-down version of the OCaml runtime that includes only what's needed
   for a unikernel, making it lightweight.

4. **MirageOS:**  
   - MirageOS is a library operating system (often called a unikernel) written in OCaml. It
   leverages ocaml-solo5 (or other backends, like Xen) to build a specialized, self-contained
   VM image.  
   - Rather than being a traditional microkernel, MirageOS packages up only the minimal "kernel"
   components (drivers, network stacks, etc.) that application requires—all written in OCaml.

So my current understanding of the Solo5-based MirageOS stack is:

- **KVM (or another hypervisor)** provides the virtualization hardware support.
- **Solo5** is the lightweight runtime that interfaces with the hypervisor.
- **ocaml-solo5** brings in the OCaml runtime, optimized for this minimal environment.
- **MirageOS** is built on top of that, assembling the libraries and drivers into a complete unikernel.
