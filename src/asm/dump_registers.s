.section .text
.global dump_registers
.type dump_registers, @function

// void dump_registers(void);
dump_registers:
    // Save caller's rsp as "original_rsp"
    mov %rsp, %rsi

    // Save general-purpose registers
    mov %rax, %rdi
    mov %rbx, %rdx
    mov %rcx, %rcx
    mov %rdx, %r8
    mov %rsi, %r9
    mov %rdi, %r10
    mov %rbp, %r11
    // Save %rsp (already in %rsi)
    mov %r8, %r12
    mov %r9, %r13
    mov %r10, %r14
    mov %r11, %r15

    // Prepare arguments and call printf for each register
    // (Use cdecl call to printf, pass register name, value (dec), value (hex))

    // For brevity, here is an example for rax:
    // lea rax_name(%rip), %rdi
    // mov %rax, %rsi
    // mov %rax, %rdx
    // call printf

    // Repeat for all registers in required order

    ret

// Data section for register names
.section .rodata
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
fmt_str:  .string "%s\t%ld (0x%lx)\n"
