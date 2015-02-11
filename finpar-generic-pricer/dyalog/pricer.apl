#!/usr/local/bin/mapl -script

⍝ Nice for debugging
⍝)clear
⍝ )copy Util DISP
)copy display


⍝ CSV file reading
⍝ from http://aplwiki.com/CsvToApl
∇r←PartitionRecordsWithDyalog string;masked;cr;lf;bool
⍝ Takes a string and partitions records.
⍝ Can deal with Mac/Unix/Windows files.
⍝ For that, CR+LF as well as single LFs are converted into CR.
⍝ CR is then used to partition "string".
 ⎕IO←1 ⋄ ⎕ML←3
 (cr lf)←⎕UCS 10 13                         ⍝ <CarriageReturn> and <LineFeed>
 :If 0<+/bool←(cr,lf)⍷string                ⍝ are there any cr+lf in "string"?
     string←(~bool)/string                  ⍝ Let only the cr survive
 :EndIf
 :If 0<+/bool←cr=string                     ⍝ Are there still any cr's?
     (bool/string)←lf                       ⍝ Convert them to lf
 :EndIf
⍝ In the remaining string, there might be lf's inside text, Those
⍝ need to be masked before we decide where records really start.
 masked←~{⍵∨≠\⍵}'"'=string                  ⍝ what is not escaped (between "")
 :If 1∊bool←lf=masked/string                ⍝ are there any unmasked lf in "string"?
     r←(~masked\bool)⊂string
 :Else ⍝ so it's a single record
     r←⊂string
 :EndIf
∇

∇r←{ignore}Csv2Numeric r;buffer
⍝ Transform cells that contain digits into numeric values, BUT:
⍝ * Commas are ignored.
⍝ * "$£€¥" are ignored because the left argument "ignore" defaults to those.
⍝ * Blanks are removed
⍝ Example:
⍝ (¯10 3 4 1234.5 12 1000  '1A')←Csv2Numeric '-10' '3' '4' '123,4.5' '£12' '1E3' '1A'
 ignore←{0<⎕NC ⍵:⍎⍵ ⋄ '$£€¥'}'ignore'
 buffer←{0=+/bool←'-'=w←⍵:⍵ ⋄ (bool/w)←'¯' ⋄ w}¨r  ⍝ "buffer" is a copy of r with "¯" for "-"
 r←buffer{(0∊⍴⍵):'' ⋄ ,↑1⊃v←⎕VFI ⍺~' ,',ignore:↑2⊃v ⋄ ⍵}¨r ⍝ make fields with appropriate content numeric
∇

∇r←{sep}Csv2MatrixWithDyalog csv;bool;⎕IO
⍝ Convert vector-of-text-vectors "csv" that is assumed to
⍝ come from  a *.csv file and which got already partitioned
⍝ into an APL matrix. Takes care of escaped stuff.
⍝ "sep" defaults to a comma but that can be changed by specifying a left argument.
 ⎕IO←1 ⋄ ⎕ML←3
 sep←{2=⎕NC ⍵:⍎⍵ ⋄ ','}'sep'
 r←(⌽∨\0≠⌽↑∘⍴¨csv)/csv          ⍝ remove empty stuff from the end if any
 bool←{~{⍵∨≠\⍵}'"'=⍵}¨r         ⍝ prepare booleans useful to mask escaped stuff
 r←⊃r{⍺⊂⍨⍵≠sep}¨bool{⍺\⍺/⍵}¨r   ⍝ partition fields by unmasked commas
 r←{'"'≠1⍴⍵:⍵ ⋄ ¯1↓1↓⍵}¨r       ⍝ remove leading and trailing "
 r←Csv2Numeric r                ⍝ Convert numeric cells
 r←(~'""'∘⍷¨r)/¨r               ⍝ double-" into a single one
∇

∇r←{sep} DealWithCsv filename;data
⍝ Read "filename" which is assumed to be a *.csv file
⍝ and convert it into a matrix
 sep←{2=⎕NC ⍵:⍎⍵ ⋄ ','}'sep'
⍝ data←FileRead filename
 tie ← filename ⎕NTIE 0
 data ← ⎕NREAD tie 80 (⎕NSIZE tie) 0
 data ← PartitionRecordsWithDyalog data
 r← ↑ ¨ sep Csv2MatrixWithDyalog data
∇

⍝ Read data file (whitespace separated numbers)
∇ data ← readFile path
  tie ← path ⎕NTIE 0
  vec ← ⎕NREAD tie 80 (⎕NSIZE tie) 0
  data ← ((⎕UCS 13) (⎕UCS 10) ' ') ⎕VFI vec
  data ← ¯1↓⊃1↓data
∇

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
num_mc_it ← 1048576
num_dates ← 5
num_under ← 3
num_models ← 1
num_bits ← 30

path ← '../data/medium/'
dirVec ← DealWithCsv (path ,'direction_vectors')
md_drifts ← DealWithCsv (path, 'md_drifts')
md_c ← DealWithCsv (path, 'md_c')
md_disc ← 5 ⍴ DealWithCsv (path, 'md_disc')
md_starts ← DealWithCsv (path, 'md_starts')
md_vols ← DealWithCsv (path, 'md_vols')
bb_data ← DealWithCsv (path, 'bb_data')
bb_ind ← DealWithCsv (path, 'bb_ind')

⍝ Sobol sequences using inductive approach
∇R←n sobolIndI dirVec;bitsNum;bits;is;is2
  bitsNum ← 1↓⍴dirVec
  bits  ← ⍳bitsNum
  is ← {⍵ testBit (grayCode n)} ¨ bits
  is2 ← dirVec × (⍴dirVec)⍴is
  R ← xor/is2
∇

∇R←n sobolIndR dirVec;bitsNum;bits;is;is2
  arri ← n sobolIndI dirVec
  bitsNum ← 1↓⍴dirVec
  R ← arri÷2*bitsNum
∇

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

∇R ← smallcase q;x;op
  x ← 0.180625 - q×q
  op ← {x×⍵ + ⍺}
  R ← q × (op/small_as) ÷ (op/small_bs)
∇

∇R ← intermediate q;x;op
  x ← q - 1.6
  op ← {⍺ + x×⍵}
  R ← (op/interm_as) ÷ (op/interm_bs)
∇

∇R ← tail q;x;op
  x ← q - 5.0
  op ← {⍺ + x×⍵}
  R ← (op/tail_as) ÷ (op/tail_bs)
∇

∇R ← ugaussianEl p;dp;pp;r;x
 dp ← p - 0.5

  ⍝ case 1
   R1 ← smallcase dp
   
  ⍝ case 2  
   pp ← 0.5 + dp×-×dp
   r ← (-⍟pp)*0.5
   x ← ((intermediate r) × r≤5.0) + (tail r) × r>5.0
   R2 ← x × ×dp

  ⍝ conditional  
  R ← (1 + 0.425≥|dp) ⊃ R2 R1
∇

ugaussian ← { ugaussianEl ¨ ⍵ }

∇R ← brownianBridge rhs;num_under;num_dates;bb_ind;bb_data;bb_bi;bb_li;bb_ri;bb_sd;bb_lw;bb_rw;gauss;sz
  (num_under num_dates bb_ind bb_data gauss) ← rhs

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
  R ← (1↓bbrow) - num_dates↑bbrow
∇

⍝ Sets the values in the upper triangle to zero
∇ m ← clearUpperTriangle m;n
  n ← 1↑⍴ m
  m ← m × (⍳n)∘.≥⍳n
∇

⍝ Black-Scholes
⍝ Currently num_under must be a constant, should be given as argument
∇ R ← md_c correlateDeltas bb_arr
  ⍝ Clear upper triangle - why are the numbers there when we don't use them?  
  R ← bb_arr +.× ⍉ clearUpperTriangle md_c
∇

∇R ← combineVs rhs;n_row;vol_row;dr_row
  (n_row vol_row dr_row) ← rhs
  R ← dr_row + n_row × vol_row
∇

∇R ← mkPrices rhs;md_starts;md_vols;md_drifts;noises
  (md_starts md_vols md_drifts noises) ← rhs
  e_rows ← *combineVs noises md_vols md_drifts
  R ← 1↓⍉×\⍉(md_starts ,[1] e_rows)
∇

∇R ← blackScholes rhs;num_paths;md_c;md_vols;md_drifts;md_starts;bb_arr
  (num_under md_c md_vols md_drifts md_starts bb_arr) ← rhs
  noises ← md_c correlateDeltas bb_arr
  R ← mkPrices (md_starts md_vols md_drifts noises)
∇

∇R ← md_disc payoff2 xss;mins;xss_div;divs
  mins ← ⌊/xss × (⍴xss)⍴ ÷ 3758.05 11840.0 1200.0

  :If mins[1] ≥ 1
    R ← 1150.0 × md_disc[1]
  :ElseIf mins[2] ≥ 1
    R ← 1300.0 × md_disc[2]
  :ElseIf mins[3] ≥ 1
    R ← 1450.0 × md_disc[3]
  :ElseIf mins[4] ≥ 1
    R ← 1600.0 × md_disc[4]
  :ElseIf mins[5] ≥ 1
    R ← 1750.0 × md_disc[5]
  :ElseIf mins[5] ≥ 0.75
    R ← 1000.0 × md_disc[5]
  :Else
    R ← mins[5] × 1000.0 × md_disc[5]
  :End
∇

∇R ← compute n;sobol_mat;gauss_mat;bb_mat;bs_mat
  payoffs ← 0
  
  :For i :In ⍳n
    sobol_mat ← i sobolIndR dirVec
    gauss_mat ← ugaussian sobol_mat

    bb_mat ← brownianBridge (num_under num_dates bb_ind bb_data gauss_mat)

    bs_mat ← blackScholes (num_under md_c md_vols md_drifts md_starts bb_mat)

    payoff ← md_disc payoff2 bs_mat
    payoffs ← payoffs + payoff
  :EndFor

  R ← payoffs÷n
∇

DISPLAY compute num_mc_it
