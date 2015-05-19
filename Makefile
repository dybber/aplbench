BENCHMARKS_TAIL=funintegral signal sobol-pi rodinia-hotspot easter blackscholes game-of-life finpar-generic-pricer primes
BENCHMARKS_APLACC=funintegral signal sobol-pi rodinia-hotspot game-of-life
BENCHMARKS_C=funintegral signal rodinia-hotspot # Single-threaded C code
BENCHMARKS_CUDA=sobol-pi rodinia-hotspot
BENCHMARKS_DYALOG=funintegral signal sobol-pi easter game-of-life finpar-generic-pricer

BENCHMARK_TAIL_DIRS=$(BENCHMARKS_TAIL:%=benchmarks/%/implementations/tail/)
BENCHMARK_APLACC_DIRS=$(BENCHMARKS_APLACC:%=benchmarks/%/implementations/aplacc/)
BENCHMARK_C_DIRS=$(BENCHMARKS_C:%=benchmarks/%/implementations/C/)
BENCHMARK_CUDA_DIRS=$(BENCHMARKS_CUDA:%=benchmarks/%/implementations/CUDA/)
BENCHMARK_DYALOG_DIRS=$(BENCHMARKS_DYALOG:%=benchmarks/%/implementations/dyalog/)

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

.PHONY: clean-dyalog
clean-dyalog:
	@(for d in $(BENCHMARK_DYALOG_DIRS); do $(MAKE) -C $$d clean; done;)


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

.PHONY: build-dyalog
build-dyalog:
	@(for d in $(BENCHMARK_DYALOG_DIRS); do $(MAKE) -C $$d build; done;)

############## Call "make bench" in all directories ##############
.PHONY: bench-tail

bench-tail: build-tail
	@echo "------------------- TAIL C Backend -------------------"
	@(for d in $(BENCHMARK_TAIL_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)
	@echo "------------------------------------------------------"

.PHONY: bench-aplacc
bench-aplacc: build-aplacc
	@echo "----------------------- APLAcc -----------------------"
	@(for d in $(BENCHMARK_APLACC_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)
	@echo "------------------------------------------------------"

.PHONY: bench-c
bench-c: build-c
	@echo "------------------------- C --------------------------"
	@(for d in $(BENCHMARK_C_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)
	@echo "------------------------------------------------------"

.PHONY: bench-cuda
bench-cuda: build-cuda
	@echo "------------------------ CUDA ------------------------"
	@(for d in $(BENCHMARK_CUDA_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)
	@echo "------------------------------------------------------"

.PHONY: bench-dyalog
bench-dyalog: build-dyalog
	@echo "----------------------- Dyalog -----------------------"
	@(for d in $(BENCHMARK_DYALOG_DIRS); do $(MAKE) -s --no-print-directory -C $$d bench; done;)
	@echo "------------------------------------------------------"
