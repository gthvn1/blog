---
title: "Starting Mini-ZOS"
categories:
  - Blog
tags:
  - zig
  - unikernel
  - xen
pin: true
---

## What is the goal of this project?

The goal of [Mini-ZOS](https://github.com/gthvn1/mini-zos) is to run a unikernel
written in [Zig](https://ziglang.org) that runs on top of [Xen](https://xenbits.xen.org/)
and provides a runtime environment for [Wasm](https://webassembly.org/) binaries...

### A Zig implementation of Mini-OS

[Mini-OS](http://xenbits.xen.org/gitweb/?p=mini-os.git;a=summary) is a small,
lightweight operating system designed to serve as a minimalistic environment
for running applications on top of the Xen hypervisor. We will take the concept
of this operating system to provide a minimalistic runtime environment for
[Wasm](https://webassembly.org/) binaries.

### Wasm runtime

WebAssembly (Wasm) runtime is an environment that allows WebAssembly code to be
executed. Several runtimes already exists in Rust and C. Again we will try to
reuse the existing stuff but in Zig.

### Finally

The first real goal is the creation of a "unikernel" in Zig to really understand
the interaction between Xen and its paravirtualized guest. The rest will be a
bonus.

## Links

- [Mini-OS](http://xenbits.xen.org/gitweb/?p=mini-os.git;a=summary)
- [Mini-ZOS](https://github.com/gthvn1/mini-zos)
- [Zig](https://ziglang.org)
- [Xen](https://xenbits.xen.org/)
- [Wasm](https://webassembly.org/)
