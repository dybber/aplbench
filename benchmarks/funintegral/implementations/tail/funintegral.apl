
f ← { 2 ÷ ⍵ + 2 }           ⍝ Function \x. 2 / (x+2)
X ← 10000000                ⍝ Valuation points per unit

test ← { ⍵ 
         domain ← 10 × (⍳X) ÷ X      ⍝ Integrate from 0 to 10
         integral ← +/ (f¨domain)÷X  ⍝ Compute integral
       }

(test bench 10) 0

⍝ Expected: 3.58351852179
⍝ Calculated w. Wolfram Alpha: https://www.wolframalpha.com/input/?i=integrate+f%28x%29%3D2%2F%28x%2B2%29+from+0+to+10
