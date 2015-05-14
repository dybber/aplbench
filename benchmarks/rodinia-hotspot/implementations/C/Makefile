# C compiler
CC = g++
CC_FLAGS = -g -fopenmp -O2 -Wno-write-strings

hotspot: 
	$(CC) $(CC_FLAGS) hotspot_openmp.cpp -o hotspot 

.PHONY: build
build: hotspot

.PHONY: bench
bench: hotspot
	./hotspot 1024 1024 360 1 ../../datasets/temp_1024 ../../datasets/power_1024

.PHONY: clean
clean:
	rm -f hotspot
