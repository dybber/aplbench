primes ← { 
  A←1↓⍳⍵
  primes ← (1=+⌿0=A∘.|A)/A
}

run ← {
  dummy ← ⍵
  ⌈/primes 10000
}

(run bench 30) 0
