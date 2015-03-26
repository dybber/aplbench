BENCHMARKS_TAIL=funintegral signal sobol-pi rodinia-hotspot easter blackscholes game-of-life
BENCHMARKS_APLACC=funintegral signal sobol-pi 
#game-of-life rodinia-hotspot easter blackscholes

TIMEFILES_TAIL=$(BENCHMARKS_TAIL:%=benchmarks/%/tail/time)
TIMEFILES_APLACC=$(BENCHMARKS_APLACC:%=benchmarks/%/aplacc/time)

TIMEFILES=$(TIMEFILES_TAIL) $(TIMEFILES_APLACC)

.PHONY: run
run: run_tail run_aplacc

.PHONY: run_tail
run_tail: $(TIMEFILES_TAIL)
	@/bin/echo '-------------------- REPORT TAIL ---------------------'
	@cat $^
	@/bin/echo '----------------------- E N D ------------------------'

.PHONY: run_aplacc
run_aplacc: $(TIMEFILES_APLACC)
	@/bin/echo '------------------ REPORT APL ACC---------------------'
	@cat $^
	@/bin/echo '----------------------- E N D ------------------------'

%/run:
	(cd `dirname $@`; ./setup)

%/out: %/run
	(cd `dirname $@`; ./run > out)

%/time: %/out
	@/bin/echo -n `dirname $@` > $@
	@/bin/echo -n '   ' >> $@
	@grep -i avg < $< | grep -i timing >> $@

clean:
	rm -rf *~
	rm -rf benchmarks/*/*/*.o benchmarks/*/tail/*.c
	rm -rf benchmarks/*/*/out benchmarks/*/*/time
	rm -rf benchmarks/*/aplacc/*.hi benchmarks/*/aplacc/*.hs
	rm -rf benchmarks/*/aplacc/*.tail
	rm -rf benchmarks/*/*/run benchmarks/*/*/*~
