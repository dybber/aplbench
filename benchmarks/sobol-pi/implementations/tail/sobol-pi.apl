dirVecf   ← ReadCSVInt '../../datasets/direction_vectors'
bitsNum   ← 30
dirVec    ← ⌷2 bitsNum ⍴ dirVecf
grayCode ← { ⍵ xor ⍵ srl 1 }

⍝ Sobol sequences using inductive approach
sobolIndI ← {
  dirVec ← ⍵
  n ← ⍺
  bits  ← ⍳bitsNum
  is ← n ∘.{⍵ testBit (grayCode ⍺)} bits
  is xor.× ⍉dirVec
}

sobolIndR ← {
  arri ← ⍺ sobolIndI ⍵
  arri÷2*bitsNum
}

⍝ Number of iterations
n ← 1000000

pi ← {
  s ← (⍳ ⍵) sobolIndR 2 30⍴dirVec ⍝ 2 dimensional sobol vector
  4×(+/1>(+/s*2)*÷2)÷⍵             ⍝ compute pi
}

test ← {
  dummy ← ⍵
  pi n
}

(test bench 30) 0
