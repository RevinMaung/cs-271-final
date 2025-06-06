#include <stdio.h>
#include <stdint.h>
#include <dlfcn.h>

void dump_backtrace(void) {
    void **frame;
    int depth = 0;

    // Get current frame pointer (rbp)
    asm("movq %%rbp, %0" : "=r"(frame));

    while (frame) {
        void *ret_addr = *(frame + 1);
        Dl_info info;

        if (dladdr(ret_addr, &info) && info.dli_sname) {
            printf("%3d: [%lx] %s () %s\n", depth, (uintptr_t)ret_addr,
                info.dli_sname, info.dli_fname);
        } else {
            printf("%3d: [%lx] (null) () %s\n", depth, (uintptr_t)ret_addr,
                info.dli_fname ? info.dli_fname : "??");
        }

        // Walk up the stack
        frame = (void **)(*frame);
        depth++;

        // Optional: break if frame or ret_addr is null
        if (!frame || !ret_addr) break;
    }
}
