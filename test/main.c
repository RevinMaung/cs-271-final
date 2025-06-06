#include <stdio.h>
#include "debug.h"

void g(void) {
    dump_registers();
    dump_backtrace();
}

void f(void) {
    g();
}

int main(void) {
    f();
    return 0;
}
