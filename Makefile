BENCHMARKS_TAIL=funintegral signal sobol-pi rodinia-hotspot easter blackscholes game-of-life finpar-generic-pricer primes
BENCHMARKS_APLACC=funintegral signal sobol-pi rodinia-hotspot easter game-of-life

BENCHMARK_TAIL_DIRS=$(BENCHMARKS_TAIL:%=benchmarks/%/implementations/tail/)
BENCHMARK_APLACC_DIRS=$(BENCHMARKS_APLACC:%=benchmarks/%/implementations/aplacc/)

# Call "make clean" in all directories
.PHONY: clean-tail
clean-tail:
	@(for d in $(BENCHMARK_TAIL_DIRS); do $(MAKE) -C $$d clean; done;)

.PHONY: clean-aplacc
clean-aplacc:
	@(for d in $(BENCHMARK_APLACC_DIRS); do $(MAKE) -C $$d clean; done;)

.PHONY: clean
clean: clean-tail clean-aplacc

# Call "make build" in all directories
.PHONY: build-tail
build-tail:
	@(for d in $(BENCHMARK_TAIL_DIRS); do $(MAKE) -C $$d build; done;)

.PHONY: build-aplacc
build-aplacc:
	@(for d in $(BENCHMARK_APLACC_DIRS); do $(MAKE) -C $$d build; done;)

.PHONY: build
build: build-tail build-aplacc


# Call "make bench" in all directories
.PHONY: bench-tail
bench-tail: build-tail
	@(for d in $(BENCHMARK_TAIL_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)

.PHONY: bench-aplacc
bench-aplacc: build-aplacc
	@(for d in $(BENCHMARK_APLACC_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)

.PHONY: bench
bench: bench-tail bench-aplacc

