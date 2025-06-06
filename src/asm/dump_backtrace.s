.section .rodata
bt_fmt: .string "%3ld: [%lx] %s () %s\n"

.section .bss
    .lcomm info, 32

.section .text
.globl dump_backtrace
.type dump_backtrace, @function

dump_backtrace:
    pushq %rbp
    movq %rsp, %rbp

    movq %rbp, %rax        # current frame pointer
    movl $0, %ebx          # frame index
    movl $16, %ecx         # max frames

bt_loop:
    movq 8(%rax), %rdx     # return address
    testq %rdx, %rdx
    je bt_end

    # Prepare dladdr(&addr, &info)
    movq %rdx, %rdi
    leaq info(%rip), %rsi
    call dladdr

    # Prepare printf("%3ld: [%lx] %s () %s\n", idx, addr, symname, fname)
    leaq bt_fmt(%rip), %rdi          # format string
    movslq %ebx, %rsi                # idx
    movq %rdx, %rdx                  # addr
    leaq info(%rip), %rcx
    movq 16(%rcx), %r8               # info.dli_sname
    movq 24(%rcx), %r9               # info.dli_fname

    subq $8, %rsp                    # align stack
    call printf
    addq $8, %rsp

    movq (%rax), %rax                # move to previous frame
    testq %rax, %rax
    je bt_end
    inc %ebx
    cmp %ebx, %ecx
    je bt_end
    jmp bt_loop

bt_end:
    popq %rbp
    ret

.extern printf
.extern dladdr
