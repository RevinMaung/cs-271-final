    .text
    .globl  dump_backtrace
    .type   dump_backtrace, @function
dump_backtrace:
   
    call    _debug_dump_backtrace
    ret

    .section .rodata
    .globl  backtrace_format_str
backtrace_format_str:
    .asciz  "%3ld: [%lx] %s () %s\n"
