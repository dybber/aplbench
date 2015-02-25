pricer.apl
----------
Functional-style APL implementation of Generic Pricer from finpar
benchmark suite

pricer-sequential.c
-------------------
Code generated w. TAIL, modified slightly:

 * Removed conditionals
 * Hoisted malloc outside loop
 * Added free's

pricer-openmp.c
---------------
Builds on pricer.sequential.c

 * One big malloc for all threads
 * Pad mallocs to avoid conflicts
 * Add OpenMP pragmas
