+++
title = "Mirageos Part2"
date = "2025-02-11T13:14:49+01:00"
#dateFormat = "2006-01-02" # This value can be configured for per-post date formatting
author = ""
authorTwitter = "" #do not include @
cover = ""
tags = ["mirageos", "kvm"]
keywords = ["", ""]
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

In this part we will focus on the KVM part. There is a full description of the
API in [The definitive KVM API](https://www.kernel.org/doc/html/latest/virt/kvm/api.html).

# Get API version

The first check will be the API. The interaction with KVM is mostly done using ioctl. The
device used is generally */dev/kvm*. Here is our first test (for fun let's try [Zig](https://ziglang.org/)):
```zig
const std = @import("std");
const linux = std.os.linux;

pub fn main() void {
    const dev_kvm = "/dev/kvm";
    const flags = linux.O{
        .ACCMODE = .RDWR,
        .CLOEXEC = true,
    };

    const fd: i32 = @intCast(linux.open(dev_kvm, flags, 0));
    defer _ = linux.close(fd);

    // KVM_GET_API_VERSION is usually defined as _IO(0xAE, 0x00), which is 0xAE00
    const KVM_GET_API_VERSION: u32 = 0xAE00;

    const version = linux.ioctl(fd, KVM_GET_API_VERSION, 0);

    std.debug.print("KVM API version: {}\n", .{version});
}
```

If everything goes well you should see `12` as the current version.
