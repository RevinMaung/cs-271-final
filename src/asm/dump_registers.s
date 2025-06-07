.section .text
.globl dump_registers
.type dump_registers, @function

dump_registers:
    pushq %rbp
    movq %rsp, %rbp

    # Print RAX
    movq %rax, %rsi
    leaq rax_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    # Print RBX
    movq %rbx, %rsi
    leaq rbx_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    # Print RCX
    movq %rcx, %rsi
    leaq rcx_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    # Print RDX
    movq %rdx, %rsi
    leaq rdx_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    # Print RSI
    movq %rsi, %rsi
    leaq rsi_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    # Print RDI
    movq %rdi, %rsi
    leaq rdi_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    # Print RSP
    movq %rsp, %rsi
    leaq rsp_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    # Print RBP
    movq %rbp, %rsi
    leaq rbp_fmt(%rip), %rdi
    xor %rax, %rax
    call printf

    popq %rbp
    ret

.section .rodata
rax_fmt: .string "RAX = 0x%016lx\n"
rbx_fmt: .string "RBX = 0x%016lx\n"
rcx_fmt: .string "RCX = 0x%016lx\n"
rdx_fmt: .string "RDX = 0x%016lx\n"
rsi_fmt: .string "RSI = 0x%016lx\n"
rdi_fmt: .string "RDI = 0x%016lx\n"
rsp_fmt: .string "RSP = 0x%016lx\n"
rbp_fmt: .string "RBP = 0x%016lx\n"

.extern printf
