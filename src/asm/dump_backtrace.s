.section .text
.globl dump_backtrace
.type dump_backtrace, @function

dump_backtrace:
    pushq %rbp
    movq %rsp, %rbp

    movq %rbp, %rax           # Current frame pointer
    movl $0, %ecx             # Frame counter

bt_loop:
    movq 8(%rax), %rdx        # Saved return address
    testq %rdx, %rdx
    je bt_end

    movq %rdx, %rsi
    leaq bt_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    movq (%rbp), %rax         # Next frame pointer (previous rbp)
    testq %rax, %rax
    je bt_end

    # Prevent infinite loops by breaking if frame pointer decreases or doesn't change
    cmpq %rbp, %rax
    jbe bt_end

    movq %rax, %rbp           # Move to previous frame
    inc %ecx
    cmp $10, %ecx             # Limit backtrace to 10 frames
    jl bt_loop

bt_end:
    popq %rbp
    ret

.section .rodata
bt_fmt: .string "Return address: 0x%016lx\n"

.extern printf
