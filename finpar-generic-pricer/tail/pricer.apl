path ← '../data/medium/'
dirVec    ← 15 30 ⍴ ReadCSVInt (path ,'direction_vectors')
bb_data   ← 3 5   ⍴ ReadCSVDouble (path, 'bb_data')
bb_ind    ← 3 5   ⍴ ReadCSVInt (path, 'bb_ind')
md_c      ← 3 3   ⍴ ReadCSVDouble (path, 'md_c')
md_starts ← 3     ⍴ ReadCSVDouble (path, 'md_starts')
md_vols   ← 5 3   ⍴ ReadCSVDouble (path, 'md_vols')
md_drifts ← 5 3   ⍴ ReadCSVDouble (path, 'md_drifts')

md_disc   ← 5     ⍴ ReadCSVDouble (path, 'md_disc')

contract ← 2
num_mc_it ← 10 ⍝ 48576
num_dates ← 5
num_under ← 3
num_models ← 1
num_bits ← 30

grayCode ← { ⍵ xor ⍵ srl 1 }

⍝ Sobol sequences using inductive approach
sobolIndI ← {
  dirVec ← ⍵
  n ← ⍺
  bitsNum ← (⍴dirVec)[⊃⍴⍴dirVec]
  bits  ← ⍳bitsNum
  is ← n ∘.{⍵ testBit (grayCode ⍺)} bits
  is xor.× ⍉dirVec
}

sobolIndR ← {
  arri ← ⍺ sobolIndI ⍵
  bitsNum ← (⍴⍵)[⊃⍴⍴⍵]
  arri÷2*bitsNum
}

⍝ TODO: implement approach by Mike Giles et al.

⍝ Implement normal distribution using the method used in R:
⍝   https://svn.r-project.org/R/trunk/src/nmath/qnorm.c
⍝   Algorithm 111 and 241 (available at JSTOR)
small_as ← 3.387132872796366608  133.14166789178437745 1971.5909503065514427 13731.693765509461125 45921.953931549871457 67265.770927008700853 33430.575583588128105 2509.0809287301226727
small_bs ← 1.0 42.313330701600911252 687.1870074920579083 5394.1960214247511077 21213.794301586595867 39307.89580009271061 28729.085735721942674 5226.495278852854561
interm_as ← 1.42343711074968357734 4.6303378461565452959 5.7694972214606914055 3.64784832476320460504 1.27045825245236838258 0.24178072517745061177 0.0227238449892691845833 (7.7454501427834140764 × 10*¯4)
interm_bs ← 1.0 2.05319162663775882187 1.6763848301838038494 0.68976733498510000455 0.14810397642748007459 0.0151986665636164571966 (5.475938084995344946 × 10*¯4) (1.05075007164441684324 × 10*¯9)
tail_as ← 6.6579046435011037772 5.4637849111641143699 1.7848265399172913358 0.29656057182850489123 0.026532189526576123093 0.0012426609473880784386 (2.71155556874348757815 × 10*¯4) (2.01033439929228813265 × 10*¯7)
tail_bs ← 1.0 0.59983220655588793769 0.13692988092273580531 0.0148753612908506148525 (7.868691311456132591 × 10*¯4) (1.8463183175100546818 × 10*¯5) (1.4215117583164458887 × 10*¯7) (2.04426310338993978564 × 10*¯15)

appr ← { (⍺×(⍺×(⍺×(⍺×(⍺×(⍺×(⍺×⍵[8]+⍵[7])+⍵[6])+⍵[5])+⍵[4])+⍵[3])+⍵[2])+⍵[1]) }

smallcase ← {
  x ← 0.180625 - ⍵×⍵
  ⍵ × (x appr small_as) ÷ (x appr small_bs)
}

intermediate ← {
  x ← ⍵ - 1.6
  (x appr interm_as) ÷ (x appr interm_bs)
}

tail ← {
  x ← ⍵ - 5.0
  (x appr tail_as) ÷ (x appr tail_bs)
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
  (R2 × (1 - 0.425≥|dp)) + R1 × (0.425≥|dp)
}

ugaussian ← { ugaussianEl ¨ ⍵ }

brownianBridge ← {
  gauss ← ⍵

  bb_bi ← bb_ind[1;]
  bb_li ← bb_ind[2;]
  bb_ri ← bb_ind[3;]
  bb_sd ← bb_data[1;]
  bb_lw ← bb_data[2;]
  bb_rw ← bb_data[3;]
  gauss2Dt ← (num_dates num_under)⍴gauss
  sz ← (⍉(num_under num_dates)⍴bb_sd) × gauss2Dt
  bbrow ← ((num_dates+1) num_under)⍴0.0

  step ← {
    next ← (bb_lw[⍵]×bbrow[bb_li[⍵]+1;]) + sz[⍵;] + (bb_rw[⍵]×bbrow[bb_ri[⍵]+1;])
    k ← bb_bi[⍵]+1
    iter ← {
      bbrow[k;⍵] ← next[⍵]
      ⍵+1
    }
    v ← (iter ⍣ num_under) 1
    ⍵+1
  }
  
  variable_not_used ← (step ⍣ num_dates) 1
  (1↓bbrow) - num_dates↑bbrow
}

⍝ Sets the values in the upper triangle to zero
clearUpperTriangle ← {
  n ← ⊃1↑⍴ ⍵
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
  md_drifts + ⍵ × md_vols
}

mkPrices ← {
  noises ← ⍵
  e_rows ← *combineVs noises

  1↓⍉×\md_starts , ⍉ e_rows
}

blackScholes ← {
  bb_arr ← ⍵
  noises ← md_c correlateDeltas bb_arr
  mkPrices noises
}

payoff2 ← {
  md_disc ← ⍺
  xss ← ⍵
  mins ← ⌊/xss × (⍴xss)⍴ ÷ 3758.05 11840.0 1200.0

  bools ← (mins ≥ 1), (mins[5] ≥ 0.75), 1
  X ← 1000.0 × md_disc[5]
  results ← (md_disc × 1000 + 150 × ⍳5), X, mins[5] × X

  (bools/results)[1]
}

compute ← {
  n ← ⍵
  payoffs ← 0
  
  sobol_mat ← (⍳⍵) sobolIndR dirVec
  gauss_mat ← ugaussian sobol_mat

  compute1 ← {
    bb_mat ← brownianBridge gauss_mat[⍵;]
    bs_mat ← blackScholes bb_mat

    md_disc payoff2 bs_mat
  }

  (+/compute1¨⍳n)÷n
}

compute num_mc_it
