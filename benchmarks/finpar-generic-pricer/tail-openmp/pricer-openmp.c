#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <omp.h>
#include <apl.h>
double kernel(int n515) {
  char a1[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'd', 'i', 'r', 'e', 'c', 't', 'i', 'o', 'n', '_', 'v', 'e', 'c', 't', 'o', 'r', 's'};
  char* a2 = (char*)malloc(sizeof(char)*33);
  for (int n4 = 0; n4 < 32; n4++) {
    a2[n4] = a1[n4];
  }
  a2[32] = '\000';
  int* a5 = (int*)malloc(sizeof(int)*1);
  int* a6 = readIntVecFile(a5,a2);
  int n7 = a5[0];
  int* a13 = (int*)malloc(sizeof(int)*450);
  for (int n15 = 0; n15 < 450; n15++) {
    int n572;
    if (n7==0) {
      n572 = 0;
    } else {
      int n571 = n15%n7;
      n572 = a6[n571];
    }
    a13[n15] = n572;
  }
  char a17[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'b', 'b', '_', 'd', 'a', 't', 'a'};
  char* a18 = (char*)malloc(sizeof(char)*23);
  for (int n20 = 0; n20 < 22; n20++) {
    a18[n20] = a17[n20];
  }
  a18[22] = '\000';
  int* a21 = (int*)malloc(sizeof(int)*1);
  double* a22 = readDoubleVecFile(a21, a18);
  int n23 = a21[0];
  double* a29 = (double*)malloc(sizeof(double)*15);
  for (int n31 = 0; n31 < 15; n31++) {
    double d570;
    if (n23==0) {
      d570 = 0.0;
    } else {
      int n569 = n31%n23;
      d570 = a22[n569];
    }
    a29[n31] = d570;
  }
  char a33[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'b', 'b', '_', 'i', 'n', 'd'};
  char* a34 = (char*)malloc(sizeof(char)*22);
  for (int n36 = 0; n36 < 21; n36++) {
    a34[n36] = a33[n36];
  }
  a34[21] = '\000';
  int* a37 = (int*)malloc(sizeof(int)*1);
  int* a38 = readIntVecFile(a37, a34);
  int n39 = a37[0];
  char a42[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'c'};
  char* a43 = (char*)malloc(sizeof(char)*20);
  for (int n45 = 0; n45 < 19; n45++) {
    a43[n45] = a42[n45];
  }
  a43[19] = '\000';
  int* a46 = (int*)malloc(sizeof(int)*1);
  double* a47 = readDoubleVecFile(a46, a43);
  int n48 = a46[0];
  double* a54 = (double*)malloc(sizeof(double)*9);
  for (int n56 = 0; n56 < 9; n56++) {
    double d568;
    if (n48==0) {
      d568 = 0.0;
    } else {
      int n567 = n56%n48;
      d568 = a47[n567];
    }
    a54[n56] = d568;
  }
  char a57[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 's', 't', 'a', 'r', 't', 's'};
  char* a58 = (char*)malloc(sizeof(char)*25);
  for (int n60 = 0; n60 < 24; n60++) {
    a58[n60] = a57[n60];
  }
  a58[24] = '\000';
  int* a61 = (int*)malloc(sizeof(int)*1);
  double* a62 = readDoubleVecFile(a61, a58);
  int n63 = a61[0];
  double* a67 = (double*)malloc(sizeof(double)*3);
  for (int n69 = 0; n69 < 3; n69++) {
    double d566;
    if (n63==0) {
      d566 = 0.0;
    } else {
      int n565 = n69%n63;
      d566 = a62[n565];
    }
    a67[n69] = d566;
  }
  char a71[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'v', 'o', 'l', 's'};
  char* a72 = (char*)malloc(sizeof(char)*23);
  for (int n74 = 0; n74 < 22; n74++) {
    a72[n74] = a71[n74];
  }
  a72[22] = '\000';
  int* a75 = (int*)malloc(sizeof(int)*1);
  double* a76 = readDoubleVecFile(a75,a72);
  int n77 = a75[0];
  double* a83 = (double*)malloc(sizeof(double)*15);
  for (int n85 = 0; n85 < 15; n85++) {
    double d564;
    if (n77==0) {
      d564 = 0.0;
    } else {
      int n563 = n85%n77;
      d564 = a76[n563];
    }
    a83[n85] = d564;
  }
  char a87[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'd', 'r', 'i', 'f', 't', 's'};
  char* a88 = (char*)malloc(sizeof(char)*25);
  for (int n90 = 0; n90 < 24; n90++) {
    a88[n90] = a87[n90];
  }
  a88[24] = '\000';
  int* a91 = (int*)malloc(sizeof(int)*1);
  double* a92 = readDoubleVecFile(a91,a88);
  int n93 = a91[0];
  double* a99 = (double*)malloc(sizeof(double)*15);
  for (int n101 = 0; n101 < 15; n101++) {
    double d562;
    if (n93==0) {
      d562 = 0.0;
    } else {
      int n561 = n101%n93;
      d562 = a92[n561];
    }
    a99[n101] = d562;
  }
  char a102[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'd', 'i', 's', 'c'};
  char* a103 = (char*)malloc(sizeof(char)*23);
  for (int n105 = 0; n105 < 22; n105++) {
    a103[n105] = a102[n105];
  }
  a103[22] = '\000';
  int* a106 = (int*)malloc(sizeof(int)*1);
  double* a107 = readDoubleVecFile(a106,a103);
  int n108 = a106[0];
  double* a112 = (double*)malloc(sizeof(double)*5);
  for (int n114 = 0; n114 < 5; n114++) {
    double d560;
    if (n108==0) {
      d560 = 0.0;
    } else {
      int n559 = n114%n108;
      d560 = a107[n559];
    }
    a112[n114] = d560;
  }
  int* a124 = (int*)malloc(sizeof(int)*5);
  for (int n126 = 0; n126 < 5; n126++) {
    int n555 = n126/5;
    int n556 = (n555*5)+n126;
    int n558;
    if (n39==0) {
      n558 = 0;
    } else {
      int n557 = n556%n39;
      n558 = a38[n557];
    }
    a124[n126] = n558;
  }
  int* a137 = (int*)malloc(sizeof(int)*5);
  for (int n139 = 0; n139 < 5; n139++) {
    int n548 = 5+n139;
    int n549 = n548%5;
    int n550 = n548/5;
    int n551 = (n550*5)+n549;
    int n553;
    if (n39==0) {
      n553 = 0;
    } else {
      int n552 = n551%n39;
      n553 = a38[n552];
    }
    a137[n139] = n553;
  }
  int* a151 = (int*)malloc(sizeof(int)*5);
  for (int n153 = 0; n153 < 5; n153++) {
    int n542 = 10+n153;
    int n543 = n542%5;
    int n544 = n542/5;
    int n545 = (n544*5)+n543;
    int n547;
    if (n39==0) {
      n547 = 0;
    } else {
      int n546 = n545%n39;
      n547 = a38[n546];
    }
    a151[n153] = n547;
  }
  double* a161 = (double*)malloc(sizeof(double)*5);
  for (int n163 = 0; n163 < 5; n163++) {
    int n540 = n163/5;
    int n541 = (n540*5)+n163;
    a161[n163] = a29[n541];
  }
  double* a172 = (double*)malloc(sizeof(double)*5);
  for (int n174 = 0; n174 < 5; n174++) {
    int n535 = 5+n174;
    int n536 = n535%5;
    int n537 = n535/5;
    int n538 = (n537*5)+n536;
    a172[n174] = a29[n538];
  }
  double* a184 = (double*)malloc(sizeof(double)*5);
  for (int n186 = 0; n186 < 5; n186++) {
    int n531 = 10+n186;
    int n532 = n531%5;
    int n533 = n531/5;
    int n534 = (n533*5)+n532;
    a184[n186] = a29[n534];
  }
  double* a197 = (double*)malloc(sizeof(double)*15);
  for (int n199 = 0; n199 < 15; n199++) {
    int n526 = n199%3;
    int n527 = n199/3;
    int n528 = (n526*5)+n527;
    double d530;
    int n529 = n528%5;
    d530 = a161[n529];
    a197[n199] = d530;
  }
  double* a221 = (double*)malloc(sizeof(double)*9);
  for (int n223 = 0; n223 < 9; n223++) {
    int n516 = n223%3;
    int n517 = n223/3;
    int n518 = (n516*3)+n517;
    int n519 = n518%3;
    int n520 = n518/3;
    int n521 = (n519*3)+n520;
    int n523;
    int n522 = n521%3;
    n523 = 1+n522;
    int n525;
    int n524 = n518%3;
    n525 = 1+n524;
    a221[n223] = a54[n518]*i2d(b2i(!(n523<n525)));
  }

  /* const int nprocs = omp_get_num_procs(); */
  const int nthreads = omp_get_max_threads();
  /* printf("Processors: %d\n", nprocs); */
  /* printf("Threads: %d\n", nthreads); */
  //printf("Allocating 2 * %d * %lu bytes\n", nprocs, sizeof(double)*18);

  double* a242_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a257_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a268_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a274_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a331_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a387_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a391_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a403_a = (double*)malloc(nthreads*sizeof(double)*64);
  double* a417_a = (double*)malloc(nthreads*sizeof(double)*64);

  int n224 = now(0);
  double d225 = 0.0;

  #pragma omp parallel
  {
    unsigned int th_id = omp_get_thread_num();
    double* a242 = a242_a + th_id*64;
    double* a257 = a257_a + th_id*64;
    double* a268 = a268_a + th_id*64;
    double* a274 = a274_a + th_id*64;
    double* a331 = a331_a + th_id*64;
    double* a387 = a387_a + th_id*64;
    double* a391 = a391_a + th_id*64;
    double* a403 = a403_a + th_id*64;
    double* a417 = a417_a + th_id*64;

  #pragma omp for reduction(+ : d225)


  for (int n226 = 0; n226 < 1048576; n226++) {
    for (int n244 = 0; n244 < 15; n244++) {
      int n492 = 0;
      for (int n493 = 0; n493 < 30; n493++) {
        int n495 = n493+(n244*30);
        bool b498;
        int n496 = n495%30;
        int n497 = xori((1+n226),shri((1+n226),1));
        b498 = !(0==andi(n497,shli(1,n496)));
        n492 = xori(n492,(a13[n495]*b2i(b498)));
      }
      a242[n244] = i2d(n492)/pow(2.0,30.0);
    }
    for (int n259 = 0; n259 < 15; n259++) {
      double d482 = a242[n259]-0.5;
      bool b483 = !(0.425<((d482<0.0) ? -d482 : d482));
      double d484 = d482;
      if (!(b483)) {
        double d485 = 0.5+(d482*i2d(-((d482<0.0) ? (-1) : 1)));
        double d486 = sqrt(-ln(d485));
        double d487 = (-5.0)+d486;
        double d488 = (-1.6)+d486;
        double d489 = (((d488*((d488*((d488*((d488*((d488*((d488*((d488*0.0234983900035)+0.241780725177))+1.27045825245))+3.64784832476))+5.76949722146))+4.63033784616))+1.42343711075))/(d488*((d488*((d488*((d488*((d488*((d488*((d488*5.4759485925e-4)+0.0151986665636))+0.148103976427))+0.689767334985))+1.67638483018))+2.05319162664))+1.0)))*i2d(b2i(d486<=5.0)))+(((d487*((d487*((d487*((d487*((d487*((d487*((d487*2.71356590314e-4)+0.00124266094739))+0.0265321895266))+0.296560571829))+1.78482653992))+5.46378491116))+6.6579046435))/(d487*((d487*((d487*((d487*((d487*((d487*((d487*1.42151177876e-7)+1.84631831751e-5))+7.86869131146e-4))+0.0148753612909))+0.136929880923))+0.599832206556))+1.0)))*i2d(b2i(!(d486<=5.0))));
        d484 = d489*i2d((d482<0.0) ? (-1) : 1);
      }
      double d490 = d484;
      if (b483) {
        double d491 = 0.180625-(d484*d484);
        d490 = d484*((d491*((d491*((d491*((d491*((d491*((d491*((d491*35939.6565123)+67265.770927))+45921.9539315))+13731.6937655))+1971.59095031))+133.141667892))+3.3871328728))/(d491*((d491*((d491*((d491*((d491*((d491*((d491*33955.5810146)+39307.8958001))+21213.7943016))+5394.19602142))+687.187007492))+42.3133307016))+1.0)));
      }
      a257[n259] = d490;
    }
    for (int n270 = 0; n270 < 15; n270++) {
      double d481 = a257[n270];
      a268[n270] = a197[n270]*d481;
    }
    for (int n276 = 0; n276 < 18; n276++) {
      a274[n276] = 0.0;
    }
    int n277 = 1;
    for (int n278 = 0; n278 < 5; n278++) {
      int n280 = (-1)+n277;
      int n282 = a137[n280];
      int n284 = n282*3;
      int n286 = (-1)+n277;
      int n288 = n286*3;
      int n290 = (-1)+n277;
      int n292 = a151[n290];
      int n294 = n292*3;
      int n298 = (-1)+n277;
      int n299 = a124[n298]+1;
      int n300 = 1;
      for (int n301 = 0; n301 < 3; n301++) {
        int n304 = (-1)+n300;
        int n305 = n304+n284;
        int n306 = n305%3;
        int n307 = n305/3;
        int n308 = (n307*3)+n306;
        int n310 = (-1)+n277;
        int n311 = n304+n288;
        int n312 = n311%3;
        int n313 = n311/3;
        int n314 = (n313*3)+n312;
        int n315 = n304+n294;
        int n316 = n315%3;
        int n317 = n315/3;
        int n318 = (n317*3)+n316;
        int n320 = (-1)+n277;
        int n321 = (-1)+n300;
        int n322 = (((-1)+n299)*3)+n321;
        a274[n322] = (a172[n310]*a274[n308])+(a268[n314]+(a184[n320]*a274[n318]));
        n300 = 1+n300;
      }
      n277 = 1+n277;
    }
    for (int n333 = 0; n333 < 15; n333++) {
      int n478 = 3+n333;
      double d479 = a274[n333];
      a331[n333] = a274[n478]-d479;
    }
    for (int n389 = 0; n389 < 18; n389++) {
      int n453 = n389%6;
      int n454 = n389/6;
      int n455 = (n453*3)+n454;
      double d477;
      if (n455<3) {
        int n456 = n455%3;
        int n457 = n455/3;
        int n458 = n456+n457;
        d477 = a67[n458];
      } else {
        int n459 = (-3)+n455;
        int n460 = n459%3;
        int n461 = n459/3;
        int n462 = (n461*3)+n460;
        int n463 = n462%3;
        int n464 = n462/3;
        double d465 = 0.0;
        for (int n466 = 0; n466 < 3; n466++) {
          int n468 = (n464*3)+n466;
          int n469 = (n463*15)+n468;
          double d471;
          int n470 = n469%15;
          d471 = a331[n470];
          int n473 = (n466*3)+n463;
          int n474 = (n464*9)+n473;
          double d476;
          int n475 = n474%9;
          d476 = a221[n475];
          d465 = d465+(d471*d476);
        }
        d477 = exp(a99[n462]+(d465*a83[n462]));
      }
      a387[n389] = d477;
    }
    for (int n392 = 0; n392 < 3; n392++) {
      int n393 = n392*6;
      for (int n394 = 0; n394 < 6; n394++) {
        int n396 = n394+n393;
        if (n394==0) {
          a391[n396] = a387[n396];
        } else {
          a391[n396] = a391[((-1)+n396)]*a387[n396];
        }
      }
    }
    for (int n405 = 0; n405 < 15; n405++) {
      int n449 = 3+n405;
      int n450 = n449%3;
      int n451 = n449/3;
      int n452 = (n450*6)+n451;
      a403[n405] = a391[n452];
    }
    double a406[] = {3758.05, 11840.0, 1200.0};
    for (int n419 = 0; n419 < 5; n419++) {
      double d445 = HUGE_VAL;
      for (int n446 = 0; n446 < 3; n446++) {
        int n447 = n446+(n419*3);
        int n448 = n447%3;
        d445 = mind(d445,(a403[n447]*(1.0/a406[n448])));
      }
      a417[n419] = d445;
    }
    bool b421 = !(a417[0]<1.0);
    double d422 = 0.0;
    if (!(b421)) {
      bool b424 = !(a417[1]<1.0);
      double d425 = 0.0;
      if (!(b424)) {
        bool b427 = !(a417[2]<1.0);
        double d428 = 0.0;
        if (!(b427)) {
          bool b430 = !(a417[3]<1.0);
          double d431 = 0.0;
          if (!(b430)) {
            bool b433 = !(a417[4]<1.0);
            double d434 = 0.0;
            if (!(b433)) {
              bool b436 = !(a417[4]<0.75);
              double d437 = 0.0;
              if (!(b436)) {
                d437 = a417[4]*(1e3*a112[4]);
              }
              double d439 = d437;
              if (b436) {
                d439 = 1e3*a112[4];
              }
              d434 = d439;
            }
            double d440 = d434;
            if (b433) {
              d440 = 1750.0*a112[4];
            }
            d431 = d440;
          }
          double d441 = d431;
          if (b430) {
            d441 = 1600.0*a112[3];
          }
          d428 = d441;
        }
        double d442 = d428;
        if (b427) {
          d442 = 1450.0*a112[2];
        }
        d425 = d442;
      }
      double d443 = d425;
      if (b424) {
        d443 = 1300.0*a112[1];
      }
      d422 = d443;
    }
    double d444 = d422;
    if (b421) {
      d444 = 1150.0*a112[0];
    }
    d225 = d225+d444;
  }
  }

  double d499 = d225/1048576.0;
  int n500 = now(1);
  free(a242_a);
  free(a257_a);
  free(a268_a);
  free(a274_a);
  free(a331_a);
  free(a387_a);
  free(a391_a);
  free(a403_a);
  free(a417_a);

  char a501[] = {'R', 'E', 'S', 'U', 'L', 'T', ':', ' '};
  char* a502 = (char*)malloc(sizeof(char)*32);
  formatD(a502,d499);
  int n503 = 8+strlen(a502);
  for (int n505 = 0; n505 < n503; n505++) {
    char c507;
    if (n505<8) {
      c507 = a501[n505];
    } else {
      int n506 = (-8)+n505;
      c507 = a502[n506];
    }
    printf("%c",c507);
  }
  printf("\n");
  char a508[] = {'T', 'I', 'M', 'I', 'N', 'G', ':', ' '};
  char* a509 = (char*)malloc(sizeof(char)*27);
  sprintf(a509,"%d",(n500-n224));
  int n510 = 8+strlen(a509);
  for (int n512 = 0; n512 < n510; n512++) {
    char c514;
    if (n512<8) {
      c514 = a508[n512];
    } else {
      int n513 = (-8)+n512;
      c514 = a509[n513];
    }
    printf("%c",c514);
  }
  printf("\n");
  return 1.0;
}

int main() {
  initialize();
  prScalarDouble(kernel(0));
  printf("\n");
  return 0;
}
