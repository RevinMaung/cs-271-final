CC=gcc
CFLAGS=-Wall -g -fPIC -Iinclude
LDFLAGS=-ldl

SRC_ASM=src/asm/dump_registers.s src/asm/dump_backtrace.s
OBJ_ASM=$(SRC_ASM:.s=.o)
TEST_SRC=test/main.c
TEST_OBJ=test/main.o
TARGET=test/main

all: $(TARGET)

$(TARGET): $(OBJ_ASM) $(TEST_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f src/asm/*.o test/*.o $(TARGET)
