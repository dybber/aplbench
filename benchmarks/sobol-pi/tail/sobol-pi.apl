dirVec    ← ⌷15 30 ⍴ ReadCSVInt '../data/direction_vectors'
grayCode ← { ⍵ xor ⍵ srl 1 }

⍝ Sobol sequences using inductive approach
sobolIndI ← {
  dirVec ← ⍵
  n ← ⍺
  bitsNum ← (⍴dirVec)[⊃⍴⍴dirVec]
  bits  ← ⍳bitsNum
  is ← ⌷n ∘.{⍵ testBit (grayCode ⍺)} bits
  is xor.× ⌷⍉dirVec
}

sobolIndR ← {
  arri ← ⍺ sobolIndI ⍵
  bitsNum ← (⍴⍵)[⊃⍴⍴⍵]
  arri÷2*bitsNum
}

⍝ Number of iterations
n ← 100000

⍝ Compute pi
t0 ← now 0

⍝ Compute 2 dimensional sobol vector
s ← (⍳n) sobolIndR 2 30⍴dirVec
pi ← 4×(+/1>(+/s*2)*÷2)÷n

t1 ← now 1
⎕ ← 'RESULT: ' , ⍕ pi
⎕ ← 'TIMING: ' , ⍕ (t1-t0)
1.0
