
f ← { 2 ÷ ⍵ + 2 }           ⍝ Function \x. 2 / (x+2)
N ← 10000000                ⍝ Valuation points per unit
dx ← 10 ÷ N

test ← {
  dummy ← ⍵ 
  domain ← dx × ⍳N             ⍝ Integrate from 0 to 10
  integral ← dx × +/(f¨domain) ⍝ Compute integral
  integral
}

r ← (test bench 10) 0

⍝ Expected: 3.58351852179
⍝ Calculated w. Wolfram Alpha: https://www.wolframalpha.com/input/?i=integrate+f%28x%29%3D2%2F%28x%2B2%29+from+0+to+10
