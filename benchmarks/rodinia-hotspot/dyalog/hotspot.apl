⍝ Ported to APL from the ELI version available at http://fastarray.appspot.com/

num_iterations ← 360 ⍝ number of iteration

hotspot ← {
  temp ← ⍺
  power ← ⍵
  t_chip ← 0.0005
  height ← width ← 0.016
  amb_temp ← 80.0
  FACTOR_CHIP←0.5
  K_SI← 100
  SPEC_HEAT_SI ← 1750000
  PRECISION ← 0.001
  MAX_PD ← 3000000

  ⍝ Additional scalar values (compute on CPU)
  Cap ← FACTOR_CHIP × SPEC_HEAT_SI × t_chip × (gw ← width ÷ col ← ¯1↑⍴temp) × gh ← height ÷ row ← 1↑⍴temp
  Rx ← gw ÷ (2.0 × K_SI × t_chip × gh)
  Ry ← gh ÷ (2.0 × K_SI × t_chip × gw)
  Rz ← t_chip ÷ (K_SI × gh × gw)
  max_slope ← MAX_PD ÷ (FACTOR_CHIP × t_chip × SPEC_HEAT_SI)
  step ← PRECISION ÷ max_slope

  k ← 0
  c1 ← c2 ← (row,col)⍴2
  c1[;1] ← 1
  c1[;col] ← 1
  c2[1;] ← 1
  c2[row;] ← 1

  iter ← {
    temp ← ⍵
    m1 ← (0 1↓temp),0
    m2 ← 0,(0 ¯1↓temp)
    x ← (m1 + m2) - c1 × temp

    n1 ← (1 0↓temp),[1]0
    n2 ← 0,[1](¯1 0)↓temp
    y ← (n1 + n2) - c2 × temp

    delta ← (step ÷ Cap) × (power + (y ÷ Ry) + (x ÷ Rx) + (amb_temp - temp) ÷ Rz)
    temp + delta
  }

  (iter ⍣ num_iterations) temp
}

⍝ data files
path ← '../data/'
size ← 512 512

temp ← size ⍴ ReadCSVDouble (path, 'temp_512')
power ← size ⍴ ReadCSVDouble (path, 'power_512')

t0 ← now 0
r ← temp hotspot power
t1 ← now 1
⎕ ← 'RESULT: ' , ⍕ ⌈/⌈/r
⎕ ← 'TIMING: ' , ⍕ (t1-t0)
1.0
