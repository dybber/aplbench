dirVecf   ← ReadCSVInt '../data/direction_vectors'
dirVec    ← ⌷15 30 ⍴ dirVecf
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
n ← 10000

⍝ Compute pi
pi ← {
  ⍝ Compute 2 dimensional sobol vector
  s ← (⍳ ⍵) sobolIndR 2 30⍴dirVec
  4×(+/1>(+/s*2)*÷2)÷⍵
}

1000 (pi bench {⍵}) n

