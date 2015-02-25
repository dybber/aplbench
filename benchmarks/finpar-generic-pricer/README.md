tail-sequential/pricer.apl
----------
Functional-style APL implementation of Generic Pricer from finpar
benchmark suite

tail-sequential
---------------
Code generated w. TAIL, modified slightly:

 * Removed bounds checks
 * Hoisted malloc outside loop
 * Added free's

tail-openmp
---------------
Builds on pricer.sequential.c

 * One big malloc for all threads
 * Pad mallocs to avoid conflicts
 * Add OpenMP pragmas
