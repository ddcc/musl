#include "syscall.h"

int futex(unsigned int *addr, int op, unsigned int val,
          const struct timespec *timeout, unsigned int *addr2,
          unsigned int addr3) {
    return syscall(__NR_futex, addr, op, val, timeout, addr2, addr3);
}
