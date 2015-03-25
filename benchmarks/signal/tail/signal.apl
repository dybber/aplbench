diff ← {1↓⍵−¯1⌽⍵}
signal ← {¯50⌈50⌊50×(diff 0,⍵)÷0.01+⍵}

test ← { 
  ⍵
  input ← {{1○⍵}¨ (⍳ ⍵) ÷ ⍵ ÷ 10}
  +/ signal input 100000000
}

(test bench 5) 0


