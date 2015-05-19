include ../../../../config

PRELUDE=../../../../lib/dyalog-prelude.apl

.PHONY: build

build: build/$(TARGET).dyalog

build/$(TARGET).dyalog: $(PRELUDE) $(APLFILE)
	mkdir -p build
	cat $(PRELUDE) $(APLFILE) > build/$(TARGET).dyalog

.PHONY: bench
bench: build/$(TARGET).dyalog
	MAXWS=2G rundyalog build/$(TARGET).dyalog 2> build/stderr.txt > build/stdout.txt
	@echo $(TARGET): `cat build/stdout.txt | grep AVGTIMING | cut -c 12-` ms, \
	                      result: `cat build/stdout.txt | grep RESULT | cut -c 9-`

clean:
	rm -rf build/
