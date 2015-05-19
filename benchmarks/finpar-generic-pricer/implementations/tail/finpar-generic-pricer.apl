path ← '../../datasets/medium/'
dirVec    ← ⌷15 30 ⍴ ReadCSVInt (path ,'direction_vectors')
bb_data   ← ⌷3 5   ⍴ ReadCSVDouble (path, 'bb_data')
bb_ind    ← 3 5   ⍴ ReadCSVInt (path, 'bb_ind')
md_c      ← ⌷3 3   ⍴ ReadCSVDouble (path, 'md_c')
md_starts ← ⌷3     ⍴ ReadCSVDouble (path, 'md_starts')
md_vols   ← ⌷5 3   ⍴ ReadCSVDouble (path, 'md_vols')
md_drifts ← ⌷5 3   ⍴ ReadCSVDouble (path, 'md_drifts')

md_disc   ← ⌷5     ⍴ ReadCSVDouble (path, 'md_disc')

bb_bi ← ⌷bb_ind[1;]
bb_li ← ⌷bb_ind[2;]
bb_ri ← ⌷bb_ind[3;]
bb_sd ← ⌷bb_data[1;]
bb_lw ← ⌷bb_data[2;]
bb_rw ← ⌷bb_data[3;]

contract ← 2
num_mc_it ← 1048576
num_dates ← 5
num_under ← 3
num_models ← 1
num_bits ← 30

bb_sd_precompute ← ⌷(⍉(num_under num_dates)⍴bb_sd)

⍝ Sets the values in the upper triangle to zero
clearUpperTriangle ← {
  n ← ⊃1↑⍴ ⍵
  ⍵ × (⍳n)∘.≥⍳n
}

⍝ Clear upper triangle - why are the numbers there when we don't use them?  
md_c_fixed ← ⌷⍉ clearUpperTriangle md_c


grayCode ← { ⍵ xor ⍵ srl 1 }

⍝Sobol sequences using inductive approach
⍝ sobolIndI ← {
⍝   dirVec ← ⍵
⍝   n ← ⍺
⍝   bitsNum ← (⍴dirVec)[⊃⍴⍴dirVec]
⍝   bits  ← ⍳bitsNum
⍝   is ← n ∘.{⍵ testBit (grayCode ⍺)} bits
⍝   is xor.× ⍉dirVec
⍝ }

⍝ sobolIndR ← {
⍝   arri ← ⍺ sobolIndI ⍵
⍝   bitsNum ← (⍴⍵)[⊃⍴⍴⍵]
⍝   arri÷2*bitsNum
⍝ }

sobolIndI ← {
  dirVec ← ⍵
  n ← ⍺
  bitsNum ← ⊃1↓⍴dirVec
  bits  ← ⍳bitsNum
  is ← {⍵ testBit (grayCode n)} ¨ bits
  is2 ← dirVec × (⍴dirVec)⍴is
  xor/is2
}

sobolIndR ← {
  arri ← ⍺ sobolIndI ⍵
  bitsNum ← ⊃1↓⍴⍵
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

else ← {(⍺⍺⍣⍺)(⍵⍵⍣(~⍺))⍵}

ugaussianEl ← {
   dp ← ⍵ - 0.5

   case2 ← { pp ← 0.5 + ⍵×-×⍵
              r ← (-⍟pp)*0.5
              x ← ((intermediate r) × r≤5.0) + (tail r) × r>5.0
              x × ×⍵
            }

   (0.425≥|dp) smallcase else case2 ⊃dp
}

ugaussian ← { ugaussianEl ¨ ⍵ }

brownianBridge ← {
  gauss ← ⍵

  gauss2Dt ← (num_dates num_under)⍴gauss
  sz ← bb_sd_precompute × gauss2Dt
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

⍝ Black-Scholes
⍝ Currently num_under must be a constant, should be given as argument
correlateDeltas ← {
  md_c ← ⍺
  bb_arr ← ⍵
  bb_arr +.× md_c_fixed
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
  mins ← ⌷⌊/xss × (⍴xss)⍴ ÷ 3758.05 11840.0 1200.0

  i ← (mins ≥ 1)⍳1
  (5 ≥ i) { dummy0 ← ⍵ ⋄ md_disc[i]×1000+150×i } else {
    dummy1 ← ⍵ ⋄ 1000×md_disc[5]×(mins[5],1)[1+0.75≤mins[5]]
  }

  ⍝ (mins[1] ≥ 1) { dummy ← ⍵ ⋄ 1150.0 × md_disc[1]} else {
  ⍝   dummy1 ← ⍵ ⋄ (mins[2] ≥ 1) { dummy2 ← ⍵ ⋄ 1300.0 × md_disc[2]} else {
  ⍝     dummy3 ← ⍵ ⋄ (mins[3] ≥ 1) { dummy4 ← ⍵ ⋄ 1450.0 × md_disc[3]} else {
  ⍝       dummy5 ← ⍵ ⋄ (mins[4] ≥ 1) { dummy6 ← ⍵ ⋄ 1600.0 × md_disc[4]} else {
  ⍝         dummy7 ← ⍵ ⋄ (mins[5] ≥ 1) { dummy8 ← ⍵ ⋄ 1750.0 × md_disc[5]} else {
  ⍝           dummy9 ← ⍵ ⋄ (mins[5] ≥ 0.75) { dummy10 ← ⍵ ⋄ 1000.0 × md_disc[5]} else {
  ⍝             dummy11 ← ⍵ ⋄ mins[5] × 1000.0 × md_disc[5]
  ⍝           } 0
  ⍝         } 0
  ⍝       } 0
  ⍝     } 0
  ⍝   } 0
  ⍝ } 0

}

compute ← {
  n ← ⍵
  payoffs ← 0
  
  compute1 ← {
    sobol_mat ← ⍵ sobolIndR dirVec
    gauss_mat ← ugaussian sobol_mat
    bb_mat ← brownianBridge gauss_mat
    bs_mat ← blackScholes bb_mat

    md_disc payoff2 bs_mat
  }

  (+/compute1¨⍳n)÷n
}

t0 ← now 0
result ← compute num_mc_it
t1 ← now 1
⎕ ← 'RESULT: ' , ⍕ result
⎕ ← 'TIMING: ' , ⍕ (t1-t0)
1.0
