#!/usr/bin/env rundyalog

⍝ Make sure we are 1-indexing
⎕IO ← 1

csv←import'../../shared/dyalog/csv.apl'

w ← 32 ⍝ word size
dec2bin ← {(w⍴2)⊤⍵}
bin2dec ← {(w⍴2)⊥⍵}

⍝ Bitwise operations
sll ← {bin2dec (⍵↓dec2bin ⍺),⍵⍴0}
srl ← {bin2dec (⍵⍴0),(-⍵)↓dec2bin ⍺}
xor ← {bin2dec (dec2bin ⍺) ≠ dec2bin ⍵}
testBit ← {(dec2bin ⍵)[w-⍺-1]} ⍝ Does not work for other than scalar arguments!

grayCode ← { ⍵ xor ⍵ srl 1 }

bitCount ← 30
dim ← 1
divisor ← 2*30


contract ← 2
num_mc_it ← 10⍝48576
num_dates ← 5
num_under ← 3
num_models ← 1
num_bits ← 30

path ← '../data/medium/'
dirVec ← csv.read (path ,'direction_vectors')
md_drifts ← csv.read (path, 'md_drifts')
md_c ← csv.read (path, 'md_c')
md_disc ← 5 ⍴ csv.read (path, 'md_disc')
md_starts ← 3 ⍴ csv.read (path, 'md_starts')
md_vols ← csv.read (path, 'md_vols')
bb_data ← csv.read (path, 'bb_data')
bb_ind ← csv.read (path, 'bb_ind')

⍝ Sobol sequences using inductive approach
sobolIndI ← {
  dirVec ← ⍵
  n ← ⍺
  bitsNum ← 1↓⍴dirVec
  bits  ← ⍳bitsNum
  is ← {⍵ testBit (grayCode n)} ¨ bits
  is2 ← dirVec × (⍴dirVec)⍴is
  xor/is2
}

sobolIndR ← {
  arri ← ⍺ sobolIndI ⍵
  bitsNum ← 1↓⍴⍵
  arri÷2*bitsNum
}

⍝ TODO: implement approach by Mike Giles et al.

⍝ Implement normal distribution using the method used in R:
⍝   https://svn.r-project.org/R/trunk/src/nmath/qnorm.c
⍝   Algorithm 111 and 241 (available at JSTOR)
small_as ←           3.387132872796366608  133.14166789178437745 1971.5909503065514427 13731.693765509461125
small_as ← small_as, 45921.953931549871457 67265.770927008700853 33430.575583588128105 2509.0809287301226727

small_bs ←            1.0                   42.313330701600911252 687.1870074920579083 5394.1960214247511077 
small_bs ← small_bs , 21213.794301586595867 39307.89580009271061 28729.085735721942674 5226.495278852854561

interm_as ←             1.42343711074968357734 4.6303378461565452959  5.7694972214606914055    3.64784832476320460504
interm_as ← interm_as , 1.27045825245236838258 0.24178072517745061177 0.0227238449892691845833 7.7454501427834140764e¯4

interm_bs ←             1.0                    2.05319162663775882187 1.6763848301838038494 0.68976733498510000455 
interm_bs ← interm_bs , 0.14810397642748007459 0.0151986665636164571966 5.475938084995344946e¯4 1.05075007164441684324e¯9

tail_as ←           6.6579046435011037772   5.4637849111641143699    1.7848265399172913358     0.29656057182850489123
tail_as ← tail_as , 0.026532189526576123093 0.0012426609473880784386 2.71155556874348757815e¯5 2.01033439929228813265e¯7

tail_bs ←            1.0                     0.59983220655588793769 0.13692988092273580531 0.0148753612908506148525
tail_bs ← tail_bs ,  7.868691311456132591e¯4 1.8463183175100546818e¯5 1.4215117583164458887e¯7 2.04426310338993978564e¯15

smallcase ← {
  x ← 0.180625 - ⍵×⍵
  op ← {x×⍵ + ⍺}
  ⍵ × (op/small_as) ÷ (op/small_bs)
}

intermediate ← {
  x ← ⍵ - 1.6
  op ← {⍺ + x×⍵}
  (op/interm_as) ÷ (op/interm_bs)
}

tail ← {
  x ← ⍵ - 5.0
  op ← {⍺ + x×⍵}
  (op/tail_as) ÷ (op/tail_bs)
}

ugaussianEl ← {
   dp ← ⍵ - 0.5

  ⍝ case 1
   R1 ← smallcase dp
   
  ⍝ case 2  
   pp ← 0.5 + dp×-×dp
   r ← (-⍟pp)*0.5
   x ← ((intermediate r) × r≤5.0) + (tail r) × r>5.0
   R2 ← x × ×dp

  ⍝ conditional  
  R2 × (1 - 0.425≥|dp) + R1 × (0.425≥|dp)
⍝  (1 + 0.425≥|dp) ⊃ R2 R1
}

ugaussian ← { ugaussianEl ¨ ⍵ }

brownianBridge ← {
  (num_under num_dates bb_ind bb_data gauss) ← ⍵

  (bb_bi bb_li bb_ri) ← (bb_ind[1;]) (bb_ind[2;]) (bb_ind[3;])
  (bb_sd bb_lw bb_rw) ← (bb_data[1;]) (bb_data[2;]) (bb_data[3;])
  gauss2Dt ← (num_dates num_under)⍴gauss
  sz ← (⍉(num_under num_dates)⍴bb_sd) × gauss2Dt
  bbrow ← ((num_dates+1) num_under)⍴0

  step ← {
    bbrow[bb_bi[⍵]+1;] ← (bb_lw[⍵]×bbrow[bb_li[⍵]+1;]) + sz[⍵;] + (bb_rw[⍵]×bbrow[bb_ri[⍵]+1;])
    ⍵+1
  }
  
  variable_not_used ← (step ⍣ num_dates) 1
  (1↓bbrow) - num_dates↑bbrow
}

⍝ Sets the values in the upper triangle to zero
clearUpperTriangle ← {
  n ← 1↑⍴ ⍵
  ⍵ × (⍳n)∘.≥⍳n
}

⍝ Black-Scholes
⍝ Currently num_under must be a constant, should be given as argument
correlateDeltas ← {
  md_c ← ⍺
  bb_arr ← ⍵  
  ⍝ Clear upper triangle - why are the numbers there when we don't use them?  
  bb_arr +.× ⍉ clearUpperTriangle md_c
}

combineVs ← {
  (n_row vol_row dr_row) ← ⍵
  dr_row + n_row × vol_row
}

mkPrices ← {
  (md_starts md_vols md_drifts noises) ← ⍵
  e_rows ← *combineVs noises md_vols md_drifts
  1↓⍉×\ md_starts , ⍉ e_rows
}

blackScholes ← {
  (num_under md_c md_vols md_drifts md_starts bb_arr) ← ⍵
  noises ← md_c correlateDeltas bb_arr
  mkPrices (md_starts md_vols md_drifts noises)
}

payoff2 ← {
  md_disc ← ⍺
  xss ← ⍵
  mins ← ⌊/xss × (⍴xss)⍴ ÷ 3758.05 11840.0 1200.0

  mins[1] ≥ 1: return ← 1150.0 × md_disc[1]
  mins[2] ≥ 1: return ← 1300.0 × md_disc[2]
  mins[3] ≥ 1: return ← 1450.0 × md_disc[3]
  mins[4] ≥ 1: return ← 1600.0 × md_disc[4]
  mins[5] ≥ 1: return ← 1750.0 × md_disc[5]
  mins[5] ≥ 0.75: return ← 1000.0 × md_disc[5]

  mins[5] × 1000.0 × md_disc[5]
}

compute ← {
  n ← ⍵
  payoffs ← 0
  
  compute1 ← {
    sobol_mat ← ⍵ sobolIndR dirVec
    gauss_mat ← ugaussian sobol_mat

    bb_mat ← brownianBridge (num_under num_dates bb_ind bb_data gauss_mat)

    bs_mat ← blackScholes (num_under md_c md_vols md_drifts md_starts bb_mat)

    md_disc payoff2 bs_mat
  }

  (+/compute1¨⍳n)÷n
}

compute num_mc_it
