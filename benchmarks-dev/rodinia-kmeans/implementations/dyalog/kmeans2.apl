#!/usr/bin/env rundyalog
⍝ Ported to APL from the ELI version available at http://fastarray.appspot.com/

⍝ Make sure we are 1-indexing
⎕IO ← 1

⍝ csv-library
csv←import'../../shared/dyalog/csv.apl'

⍝ settings
max_iterations ← 500
nclusters ← 5

⍝ data
path ← '../data/'
file ← '100.csv'

dataset ← csv.read (path, file)

⍝ kmeans for compilation
kmeans ← {
  k ← ⍺
  feature ← ⍵
  ⍝ mb = cluster membership (values 1 to k)
  ⍝ index = index of nearest cluster center (values 1 to k)
  ⍝ delta = how many should be moved
  loop ← ¯1
  df ← ⍴feature
  np ← 1 ↑ df
  index ← np ⍴ ¯1  ⍝ 1

  ⍝ Select k cluster centers
  nc ← k, df[2]
  clusters ← nc ↑ feature     ⍝2

  step ← {
    index ← ⊃⍵[1]
    iteration ← ⊃⍵[2]

    curp ← 0
    preclust ← nc ⍴ 0               ⍝3
    preclen ← k ⍴ 0                 ⍝4

    iter ← {
      curp ← ⍵
      dist ← +/ ((nc ⍴ feature[curp;]) - clusters) * 2  ⍝6
      t0 ← dist ⍳ ⌊/ dist
      index[curp] ← t0
      preclust[t0;] ← preclust[t0;] + feature[curp;] ⍝7
      preclen[t0]  ← preclen[t0]  + 1                ⍝8
    }

    v ← iter ⍣ np  

    clusters[t2;] ← preclust[t2;] ÷ ⍉ (df[2],⍴t2) ⍴ preclen[t2 ← t1 / ⍳⍴t1 ← preclen ≠ 0]

    ((⊂index), ⊂iteration+1)
  }

  stopcondition ← {
    prev_arr ← ⊃⍺[1]
    new_arr ← ⊃⍵[1]
    iteration ← ⊃⍵[2]

    delta ← +/ prev_arr ≠ new_arr

    ((delta < 1) ∨ (max_iterations < iteration))
  }

  step ((⊂index), ⊂1)
⍝  not_used ← (step ⍣ stopcondition) ((⊂index), ⊂1)
  ⎕←clusters
  1
}

nclusters kmeans dataset
