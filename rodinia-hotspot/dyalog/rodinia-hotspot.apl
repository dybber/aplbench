#!/usr/local/bin/mapl -script

⍝ Ported to APL from the ELI version available at http://fastarray.appspot.com/

num_iterations ← 2 ⍝ number of iteration

∇ data ← path readFile filename
  tie ← (path, filename) ⎕NTIE 0
  vec ← ⎕NREAD tie 80 (⎕NSIZE tie) 0
  data ← ((⎕UCS 13) (⎕UCS 10) ' ') ⎕VFI vec
  data ← ¯1↓⊃1↓data
∇

∇ z ← temp hotspot power;Cap;Rx;Ry;Rz;step;k;cnt;m1;m2;x;n1;n2;y;c1;c2;row;col;gw;gh
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

  ⍝ ⍞←'step size: ' 
  ⍝ ⍞ ← step
  ⍝ ⍞ ← ⎕TC  
  ⍝ ⍞ ← 'Rx Ry Rz Cap'
  ⍝ ⍞ ← ⎕TC  
  ⍝ ⍞ ← Rx Ry Rz Cap
  ⍝ ⍞ ← ⎕TC  

  k ← 0
  c1 ← c2 ← (row,col)⍴2
  c1[;1] ← 1
  c1[;col] ← 1
  c2[1;] ← 1
  c2[row;] ← 1

  :For k :In ⍳num_iterations
    m1 ← (0 1↓temp),0
    m2 ← 0,(0 ¯1↓temp)
    x ← (m1 + m2) - c1 × temp

    n1 ← (1 0↓temp),[1]0
    n2 ← 0,[1](¯1 0)↓temp
    y ← (n1 + n2) - c2 × temp

    delta ← (step ÷ Cap) × (power + (y ÷ Ry) + (x ÷ Rx) + (amb_temp - temp) ÷ Rz)
    temp ← temp + delta
  :EndFor

  z ← temp
∇

⍝ data files
datapath ← '../data/'
temp_file ← 'temp_512'
power_file ← 'power_512'
size ← 512 512

temp ← size ⍴ datapath readFile temp_file
power ← size ⍴ datapath readFile power_file

r ← temp hotspot power
