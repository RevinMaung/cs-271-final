.section .rodata
reg_fmt: .string "%s\t%ld (0x%lx)\n"
rax_name: .string "rax"
rbx_name: .string "rbx"
rcx_name: .string "rcx"
rdx_name: .string "rdx"
rsi_name: .string "rsi"
rdi_name: .string "rdi"
rbp_name: .string "rbp"
rsp_name: .string "rsp"
r8_name:  .string "r8"
r9_name:  .string "r9"
r10_name: .string "r10"
r11_name: .string "r11"
r12_name: .string "r12"
r13_name: .string "r13"
r14_name: .string "r14"
r15_name: .string "r15"

.section .text
.globl dump_registers
.type dump_registers, @function

dump_registers:
    # Save callee-saved registers and the incoming rsp
    pushq %rbp
    movq %rsp, %rbp
    movq %rsp, %r14         # Save original rsp in r14 (callee-saved, so safe to use)

    # Print rax
    leaq rax_name(%rip), %rdi
    movq %rax, %rsi
    movq %rax, %rdx
    call print_reg

    # Print rbx
    leaq rbx_name(%rip), %rdi
    movq %rbx, %rsi
    movq %rbx, %rdx
    call print_reg

    # Print rcx
    leaq rcx_name(%rip), %rdi
    movq %rcx, %rsi
    movq %rcx, %rdx
    call print_reg

    # Print rdx
    leaq rdx_name(%rip), %rdi
    movq %rdx, %rsi
    movq %rdx, %rdx
    call print_reg

    # Print rsi
    leaq rsi_name(%rip), %rdi
    movq %rsi, %rsi
    movq %rsi, %rdx
    call print_reg

    # Print rdi
    leaq rdi_name(%rip), %rdi
    movq %rdi, %rsi
    movq %rdi, %rdx
    call print_reg

    # Print rbp
    leaq rbp_name(%rip), %rdi
    movq %rbp, %rsi
    movq %rbp, %rdx
    call print_reg

    # Print rsp (original, before function call)
    leaq rsp_name(%rip), %rdi
    movq %r14, %rsi
    movq %r14, %rdx
    call print_reg

    # Print r8
    leaq r8_name(%rip), %rdi
    movq %r8, %rsi
    movq %r8, %rdx
    call print_reg

    # Print r9
    leaq r9_name(%rip), %rdi
    movq %r9, %rsi
    movq %r9, %rdx
    call print_reg

    # Print r10
    leaq r10_name(%rip), %rdi
    movq %r10, %rsi
    movq %r10, %rdx
    call print_reg

    # Print r11
    leaq r11_name(%rip), %rdi
    movq %r11, %rsi
    movq %r11, %rdx
    call print_reg

    # Print r12
    leaq r12_name(%rip), %rdi
    movq %r12, %rsi
    movq %r12, %rdx
    call print_reg

    # Print r13
    leaq r13_name(%rip), %rdi
    movq %r13, %rsi
    movq %r13, %rdx
    call print_reg

    # Print r14
    leaq r14_name(%rip), %rdi
    movq %r14, %rsi
    movq %r14, %rdx
    call print_reg

    # Print r15
    leaq r15_name(%rip), %rdi
    movq %r15, %rsi
    movq %r15, %rdx
    call print_reg

    popq %rbp
    ret

# print_reg function: expects
# rdi = pointer to name
# rsi = value (decimal)
# rdx = value (hex)
print_reg:
    pushq %rbp
    movq %rsp, %rbp
    movq %rdi, %rdi   # name
    movq %rsi, %rsi   # value (decimal)
    movq %rdx, %rdx   # value (hex)
    leaq reg_fmt(%rip), %rcx
    movq %rcx, %rdi   # format string
    movq %rsi, %rsi   # value (decimal)
    movq %rdx, %rdx   # value (hex)
    subq $8, %rsp     # align stack for printf call
    call printf
    addq $8, %rsp
    popq %rbp
    ret

.extern printf
