t0 ← now 0
A←1↓⍳10000
primes ← (1=+⌿0=A∘.|A)/A

a← ⌈/ primes
t1 ← now 1
⎕ ← 'RESULT: ' , a
⎕ ← 'TIMING: ' , ⍕ (t1-t0)
1.0
