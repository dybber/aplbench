primes ← { 
  A←1↓⍳⍵
  primes ← (1=+⌿0=A∘.|A)/A
}

100 (primes bench {⌈/⍵}) 10000
