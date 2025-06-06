#ifndef DEBUG_H
#define DEBUG_H

// Print all general-purpose register values (int and hex)
void dump_registers(void);

// Print backtrace with function names and addresses
void dump_backtrace(void);

#endif // DEBUG_H
