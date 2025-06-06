#ifndef DEBUG_H
#define DEBUG_H

#ifdef __cplusplus
extern "C" {
#endif

void dump_registers(void);
void dump_backtrace(void);

#ifdef __cplusplus
}
#endif

#endif // DEBUG_H
