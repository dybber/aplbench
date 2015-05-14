APLTAIL=$(HOME)/Documents/research/tail/apltail
GCC_OPT=-O1

APLT=$(APLTAIL)/aplt
PRELUDE=$(APLTAIL)/lib/prelude.apl

.PHONY: build

build: build/$(TARGET)

build/$(TARGET).c:
	mkdir -p build
	$(APLTAIL)/aplt -unsafe -c -O 2 -oc build/$(TARGET).c $(APLTAIL)/lib/prelude.apl $(TARGET).apl

build/$(TARGET): build/$(TARGET).c
	gcc -I "$(APLTAIL)/include/" -O3 -std=c99 build/$(TARGET).c -lm -o build/$(TARGET)

.PHONY: build/$(TARGET).results
build/$(TARGET).results: build/$(TARGET)
	./build/$(TARGET) > build/$(TARGET).results

.PHONY: bench
bench: build/$(TARGET).results
	@echo TAIL C $(TARGET) time: `cat build/$(TARGET).results | grep AVGTIMING | cut -c 12- | xargs printf "%.0f"` ms
	@echo TAIL C $(TARGET) result: `cat build/$(TARGET).results | grep RESULT | cut -c 9-`


clean:
	rm -rf build/
