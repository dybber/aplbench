# C compiler
CC = gcc
CC_FLAGS = -g -std=c99 -O3

build/signal:
	mkdir -p build
	$(CC) $(CC_FLAGS) signal.c -lm -o build/signal

.PHONY: build
build: build/signal

.PHONY: bench
bench: build
	./build/signal

.PHONY: clean
clean:
	rm -rf build
