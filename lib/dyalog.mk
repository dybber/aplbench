include ../../../../config

PRELUDE=../../../../lib/dyalog-prelude.apl

.PHONY: build

build: build/$(TARGET).dyalog

build/$(TARGET).dyalog: $(PRELUDE) $(APLFILE)
	mkdir -p build
	cat $(PRELUDE) $(APLFILE) > build/$(TARGET).dyalog

.INTERMEDIATE: build/$(TARGET).results
build/$(TARGET).results: build/$(TARGET).dyalog
	MAXWS=2G rundyalog build/$(TARGET).dyalog > build/$(TARGET).results

.PHONY: bench
bench: build/$(TARGET).results
	@echo $(TARGET): `cat build/$(TARGET).results | grep TIMING | cut -c 9-` ms, \
	                      result: `cat build/$(TARGET).results | grep RESULT | cut -c 9-`

clean:
	rm -rf build/
