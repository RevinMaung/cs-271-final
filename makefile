CC=gcc
AS=gcc
CFLAGS=-Wall -g -fPIC -Iinclude
LDFLAGS=-ldl

ASM_SRCS=$(wildcard src/asm/*.s)
ASM_OBJS=$(ASM_SRCS:.s=.o)
C_SRCS=$(wildcard src/*.c)
C_OBJS=$(C_SRCS:.c=.o)

all: test/main

src/asm/%.o: src/asm/%.s
	$(AS) $(CFLAGS) -c $< -o $@

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

test/main: $(ASM_OBJS) $(C_OBJS) test/main.c
	$(CC) $(CFLAGS) -o $@ $(ASM_OBJS) $(C_OBJS) test/main.c $(LDFLAGS)

clean:
	rm -f src/*.o src/asm/*.o test/main
