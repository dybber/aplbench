# C compiler
CC = gcc
CC_FLAGS = -g -std=c99 -O3

build/funintegral: funintegral.c
	mkdir -p build
	$(CC) $(CC_FLAGS) funintegral.c -o build/funintegral

.PHONY: build
build: build/funintegral

.PHONY: bench
bench: build
	./build/funintegral

.PHONY: clean
clean:
	rm -rf build
