BENCHMARKS_TAIL=funintegral signal sobol-pi rodinia-hotspot easter blackscholes game-of-life finpar-generic-pricer primes
BENCHMARKS_APLACC=funintegral signal sobol-pi rodinia-hotspot game-of-life
BENCHMARKS_C=rodinia-hotspot # Single-threaded C code
BENCHMARKS_CUDA=sobol-pi rodinia-hotspot

BENCHMARK_TAIL_DIRS=$(BENCHMARKS_TAIL:%=benchmarks/%/implementations/tail/)
BENCHMARK_APLACC_DIRS=$(BENCHMARKS_APLACC:%=benchmarks/%/implementations/aplacc/)
BENCHMARK_C_DIRS=$(BENCHMARKS_C:%=benchmarks/%/implementations/C/)
BENCHMARK_CUDA_DIRS=$(BENCHMARKS_CUDA:%=benchmarks/%/implementations/CUDA/)

.PHONY: bench
bench: bench-tail bench-aplacc bench-c bench-cuda

.PHONY: bench-no-cuda
bench-no-cuda: bench-tail bench-aplacc bench-c

.PHONY: build
build: build-tail build-aplacc build-c build-cuda

.PHONY: build-no-cuda
build-no-cuda: build-tail build-aplacc build-c

.PHONY: clean
clean: clean-tail clean-aplacc clean-c clean-cuda

############## Call "make clean" in all directories ##############
.PHONY: clean-tail
clean-tail:
	@(for d in $(BENCHMARK_TAIL_DIRS); do $(MAKE) -C $$d clean; done;)

.PHONY: clean-aplacc
clean-aplacc:
	@(for d in $(BENCHMARK_APLACC_DIRS); do $(MAKE) -C $$d clean; done;)

.PHONY: clean-c
clean-c:
	@(for d in $(BENCHMARK_C_DIRS); do $(MAKE) -C $$d clean; done;)

.PHONY: clean-cuda
clean-cuda:
	@(for d in $(BENCHMARK_CUDA_DIRS); do $(MAKE) -C $$d clean; done;)


############## Call "make build" in all directories ##############
.PHONY: build-tail
build-tail:
	@(for d in $(BENCHMARK_TAIL_DIRS); do $(MAKE) -C $$d build; done;)

.PHONY: build-aplacc
build-aplacc:
	@(for d in $(BENCHMARK_APLACC_DIRS); do $(MAKE) -C $$d build; done;)

.PHONY: build-c
build-c:
	@(for d in $(BENCHMARK_C_DIRS); do $(MAKE) -C $$d build; done;)

.PHONY: build-cuda
build-cuda:
	@(for d in $(BENCHMARK_CUDA_DIRS); do $(MAKE) -C $$d build; done;)

############## Call "make bench" in all directories ##############
.PHONY: bench-tail
bench-tail: build-tail
	@(for d in $(BENCHMARK_TAIL_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)

.PHONY: bench-aplacc
bench-aplacc: build-aplacc
	@(for d in $(BENCHMARK_APLACC_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)

.PHONY: bench-c
bench-c: build-c
	@(for d in $(BENCHMARK_C_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)

.PHONY: bench-cuda
bench-cuda: build-cuda
	@(for d in $(BENCHMARK_CUDA_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)
