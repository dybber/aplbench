diff ← {1↓⍵−¯1⌽⍵}
signal ← {¯50⌈50⌊50×(diff 0,⍵)÷0.01+⍵}
n ← 50000000

⍝ Compute input signal before benchmarking!
input ← ⌷({1○⍵}¨ (⍳n) ÷ n ÷ 10)

test ← { 
  ⍵
  +/ signal input
}

(test bench 30) 0

⍝ Expected result: 158.7653869
⍝ Computed w. Dyalog APL
