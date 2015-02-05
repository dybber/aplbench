#!/usr/local/bin/mapl -script

⍝ Reads a data file (white space separated numbers)
∇ data ← path readFile filename
  tie ← (path, filename) ⎕NTIE 0
  vec ← ⎕NREAD tie 80 (⎕NSIZE tie) 0
  data ← ((⎕UCS 13) (⎕UCS 10) ' ') ⎕VFI vec
  data ← ¯1↓⊃1↓data
∇

⍝ settings
max_iterations ← 500
nclusters ← 5

⍝ data
datapath ← '../data/'
file ← '100'
size ← 100 35

⍝ kmeans for compilation
∇clusters←k kmeans feature;np;nc;t0;t1;t2;df;dist;index;mb;preclust;preclen;curp;loop;delta
  ⍝ mb = cluster membership (values 1 to k)
  ⍝ index = index of nearest cluster center (values 1 to k)
  ⍝ delta = how many should be moved
  mb ← index ← (np ← 1 ↑ df ← ⍴feature) ⍴ loop ← ¯1  ⍝ 1

  ⍝ Select k cluster centers (just taking the first five)
  clusters ← (nc ← k, df[2]) ↑ feature     ⍝2

  :Repeat  
    preclust ← nc ⍴ curp ← 0               ⍝3
    preclen ← k ⍴ 0                         ⍝4

    :While (np ≥ curp ← curp + 1)
      index[curp] ← t0 ← dist ⍳ ⌊/ dist ← +/ ((nc ⍴ feature[curp;]) - clusters) * 2  ⍝6
      preclust[t0;] ← preclust[t0;] + feature[curp;] ⍝7
      preclen[t0]  ← preclen[t0]  + 1                ⍝8
    :EndWhile

    delta ← +/ mb ≠ index
    clusters[t2;] ← preclust[t2;] ÷ ⍉ (df[2],⍴t2) ⍴ preclen[t2 ← t1 / ⍳⍴t1 ← preclen ≠ 0]
    mb ← index

  :Until ((delta < 1) ∨ (max_iterations < loop))
∇

⍞ ← ⎕TC  
dataset ← size ⍴ datapath readFile file
nclusters kmeans dataset
