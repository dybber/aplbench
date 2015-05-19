include ../../../../config

APLT=$(APLTAIL)/aplt
PRELUDE=$(APLTAIL)/lib/prelude.apl

.PHONY: build

build: build/$(TARGET)

.INTERMEDIATE: build/$(TARGET).tail
build/$(TARGET).tail: $(APLTAIL)/lib/prelude.apl $(APLFILE)
	mkdir -p build
	$(APLTAIL)/aplt -c -O 2 -s_tail -p_tail -p_types -o build/$(TARGET).tail $(APLTAIL)/lib/prelude.apl $(APLFILE)

.INTERMEDIATE: build/$(TARGET).hs
build/$(TARGET).hs: build/$(TARGET).tail
	aplacc -t $(APLACC_OPT) build/$(TARGET).tail > build/$(TARGET).hs

build/$(TARGET): build/$(TARGET).hs .FORCE
	ghc -O3 -threaded build/$(TARGET).hs -o build/$(TARGET)

.PHONY: bench
bench: build/$(TARGET) build/$(TARGET)
  ./build/$(TARGET) 2> build/stderr.txt > build/stdout.txt
	@echo $(TARGET): `cat build/stdout.txt | grep AVGTIMING | cut -c 12- | xargs printf "%.3f"` ms, \
	                      result: `cat build/stdout.txt | grep -oP '(?<=RESULT: Array \(Z\) \[)([0-9]+(\.[0-9]+)?)(?=\])'`

clean:
	rm -rf build/
