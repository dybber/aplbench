#!/usr/bin/env rundyalog

⍝ Make sure we are 1-indexing
⎕IO ← 1

csv←import'../../shared/dyalog/csv.apl'

w ← 32 ⍝ word size
dec2bin ← {(w⍴2)⊤⍵}
bin2dec ← {(w⍴2)⊥⍵}

⍝ Bitwise operations
sll ← {bin2dec (⍵↓dec2bin ⍺),⍵⍴0}
srl ← {bin2dec (⍵⍴0),(-⍵)↓dec2bin ⍺}
xor ← {bin2dec (dec2bin ⍺) ≠ dec2bin ⍵}
testBit ← {(dec2bin ⍵)[w-⍺-1]} ⍝ Does not work for other than scalar arguments!

grayCode ← { ⍵ xor ⍵ srl 1 }

path ← '../data/'
dirVec ← csv.read (path ,'direction_vectors')
⎕ ← 2
⎕← (⍳10) ∘.testBit ⍳30 

⎕←⍴dirVec
⍝ Sobol sequences using inductive approach
sobolIndI ← {
  dirVec ← ⍵
  n ← ⍺
  bitsNum ← (⍴dirVec)[⍴⍴dirVec]
  bits  ← ⍳bitsNum
  is ← n ∘.{⍵ testBit (grayCode ⍺)} bits
  is xor.× ⍉dirVec 
}

sobolIndR ← {
  arri ← ⍺ sobolIndI ⍵
  bitsNum ← (⍴⍵)[⍴⍴⍵]
  arri÷2*bitsNum
}

⍝ Number of iterations
n ← 100000

⍝ Compute 2 dimensional sobol vector
s ← (⍳n) sobolIndR dirVec[1 2;]

⍝ Compute pi
pi ← 4×(+/1>(+/s*2)*÷2)÷n
pi
