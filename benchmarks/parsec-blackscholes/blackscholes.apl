
⍝ BlkSchls : int * (float * float * float * float * float * char -> float
∇OptionPrice←BlkSchls RARG;sptprice;strike;rate;volatility;time;otype;otypeC;xRiskFreeRate;xSqrtTime;logValues;xLogTerm;xD1;xD2;xPowerTerm;xDen;d1;d2;FutureValueX;NofXd1;NofXd2;valuex;out1;out2;out3
  (sptprice strike rate volatility time otypeC) ← RARG
  xSqrtTime ← time * 0.5
  xLogTerm  ← logValues ← ⍟ sptprice ÷ strike
  xRiskFreeRate ← rate
  otype ← otypeC='P' ⍝ 5
  d1 ← xD1 ← (xLogTerm + time × xRiskFreeRate + xPowerTerm ← volatility × volatility × 0.5) ÷ xDen ← volatility × xSqrtTime
  d2 ← xD2 ← xD1 - xDen ⍝ 7
  invs2xPI ← 0.39894228040143270286 ⍝ 8
  NofXd1 ← CNDF( d1 ) ⍝ 9
  NofXd2 ← CNDF( d2 ) ⍝ 10
  FutureValueX ← strike × * - rate × time
  OptionPrice ← otype × (FutureValueX × 1.0 - NofXd2) - (sptprice × 1.0 - NofXd1)
  OptionPrice ← OptionPrice + (~otype) × (sptprice × NofXd1) - (FutureValueX × NofXd2)
∇

∇ OutputX ← CNDF InputX;sign;xInput;xNPrimeofX;expValues;xK2;xK2_2;xK2_3;xK2_4;xK2_5;xLocal;xLocal_1;xLocal_2;xLocal_22;xLocal_23;xLocal_24;xLocal_25;xa1;xa2;xOut1;xOut2
  sign ← InputX < 0
  xInput ← | InputX 
  xNPrimeofX ← invs2xPI × expValues ← * _0.5 × InputX × InputX
  xK2_5 ← xK2 × xK2_4 ← xK2 × xK2_3 ← xK2 × xK2_2 ← xK2 × xK2 ← 1.0 ÷ 1.0 + 0.2316419 × xInput
  xLocal_1 ← xK2 × 0.319381530     ⍝  9
  xLocal_2 ← (xK2_2 × _0.356563782) + (xK2_3 × 1.781477937) + (xK2_4 × _1.821255978) + xK2_5 × 1.330274429
  OutputX ← (sign × 1.0 - xLocal) + (~sign) × xLocal ← 1.0 - xNPrimeofX × xLocal_2 + xLocal_1
∇


⍝ ELI type declaration


⍝ &LPARM C 1 18
⍝ 'BlkSchls I(EEEEEC)'
⍝ &

⍝ &RPARM I 1 14
⍝ 0 0 1 _1 1 _1 1 _1 1 _1 1 _1 1 _1
⍝ &
