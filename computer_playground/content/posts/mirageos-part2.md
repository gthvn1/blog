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
device used is generally */dev/kvm*. Here is our first test:
```c
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

#include <linux/kvm.h>

int kvm_get_api_version(const char *device_path) {
    int fd = open(device_path, O_RDWR);
    if (fd < 0) {
        perror("open");
        return -1;
    }
    int version = ioctl(fd, KVM_GET_API_VERSION, 0);
    if (version < 0) {
        perror("ioctl");
    }
    close(fd);
    return version;
}

int main() {
  int ver = kvm_get_api_version("/dev/kvm");
  printf("Ver %d\n", ver);
  return 0;
}
```

If everything goes well you should see `12` as the current version.
