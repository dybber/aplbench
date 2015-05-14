primes ← { 
  A←1↓⍳⍵
  primes ← (1=+⌿0=A∘.|A)/A
}

⍝ 100 (primes bench {⌈/⍵}) 10000

run ← {
  ⍵ + 1
  ⌈/primes 10000
}

(run bench 30) 0
