CC = gcc
AS = gcc
CFLAGS = -Wall -g -fPIC -Iinclude
LDFLAGS = -ldl

C_SRCS := $(wildcard src/*.c)
C_OBJS := $(C_SRCS:.c=.o)
ASM_SRCS := $(wildcard src/asm/*.s)
ASM_OBJS := $(ASM_SRCS:.s=.o)

all: test/main

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

src/asm/%.o: src/asm/%.s
	$(AS) $(CFLAGS) -c $< -o $@

test/main: $(C_OBJS) $(ASM_OBJS) test/main.c
	$(CC) $(CFLAGS) -o $@ $(C_OBJS) $(ASM_OBJS) test/main.c $(LDFLAGS)

clean:
	rm -f src/*.o src/asm/*.o test/main
