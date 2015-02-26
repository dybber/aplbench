#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <omp.h>
#include <apl.h>
double kernel(int n595) {
  char a1[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'd', 'i', 'r', 'e', 'c', 't', 'i', 'o', 'n', '_', 'v', 'e', 'c', 't', 'o', 'r', 's'};
  char* a2 = (char*)malloc(sizeof(char)*33);
  for (int n4 = 0; n4 < 32; n4++) {
    a2[n4] = a1[n4];
  }
  a2[32] = '\000';
  int* a5 = (int*)malloc(sizeof(int)*1);
  int* a6 = readIntVecFile(a2,a5);
  int n7 = a5[0];
  char a10[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'b', 'b', '_', 'd', 'a', 't', 'a'};
  char* a11 = (char*)malloc(sizeof(char)*23);
  for (int n13 = 0; n13 < 22; n13++) {
    a11[n13] = a10[n13];
  }
  a11[22] = '\000';
  int* a14 = (int*)malloc(sizeof(int)*1);
  double* a15 = readDoubleVecFile(a11,a14);
  int n16 = a14[0];
  char a19[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'b', 'b', '_', 'i', 'n', 'd'};
  char* a20 = (char*)malloc(sizeof(char)*22);
  for (int n22 = 0; n22 < 21; n22++) {
    a20[n22] = a19[n22];
  }
  a20[21] = '\000';
  int* a23 = (int*)malloc(sizeof(int)*1);
  int* a24 = readIntVecFile(a20,a23);
  int n25 = a23[0];
  char a28[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'c'};
  char* a29 = (char*)malloc(sizeof(char)*20);
  for (int n31 = 0; n31 < 19; n31++) {
    a29[n31] = a28[n31];
  }
  a29[19] = '\000';
  int* a32 = (int*)malloc(sizeof(int)*1);
  double* a33 = readDoubleVecFile(a29,a32);
  int n34 = a32[0];
  char a36[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 's', 't', 'a', 'r', 't', 's'};
  char* a37 = (char*)malloc(sizeof(char)*25);
  for (int n39 = 0; n39 < 24; n39++) {
    a37[n39] = a36[n39];
  }
  a37[24] = '\000';
  int* a40 = (int*)malloc(sizeof(int)*1);
  double* a41 = readDoubleVecFile(a37,a40);
  int n42 = a40[0];
  char a44[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'v', 'o', 'l', 's'};
  char* a45 = (char*)malloc(sizeof(char)*23);
  for (int n47 = 0; n47 < 22; n47++) {
    a45[n47] = a44[n47];
  }
  a45[22] = '\000';
  int* a48 = (int*)malloc(sizeof(int)*1);
  double* a49 = readDoubleVecFile(a45,a48);
  int n50 = a48[0];
  char a53[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'd', 'r', 'i', 'f', 't', 's'};
  char* a54 = (char*)malloc(sizeof(char)*25);
  for (int n56 = 0; n56 < 24; n56++) {
    a54[n56] = a53[n56];
  }
  a54[24] = '\000';
  int* a57 = (int*)malloc(sizeof(int)*1);
  double* a58 = readDoubleVecFile(a54,a57);
  int n59 = a57[0];
  char a61[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'm', 'e', 'd', 'i', 'u', 'm', '/', 'm', 'd', '_', 'd', 'i', 's', 'c'};
  char* a62 = (char*)malloc(sizeof(char)*23);
  for (int n64 = 0; n64 < 22; n64++) {
    a62[n64] = a61[n64];
  }
  a62[22] = '\000';
  int* a65 = (int*)malloc(sizeof(int)*1);
  double* a66 = readDoubleVecFile(a62,a65);
  int n67 = a65[0];
  int n72 = now(0);
  double d133 = 0.0;

  /* const int nprocs = omp_get_num_procs(); */
  const int nthreads = omp_get_max_threads();
  /* printf("Processors: %d\n", nprocs); */
  /* printf("Threads: %d\n", nthreads); */
  //printf("Allocating 2 * %d * %lu bytes\n", nprocs, sizeof(double)*18);
  double* a162_all = (double*)malloc(nthreads*sizeof(double)*64);
  double* a396_all = (double*)malloc(nthreads*sizeof(double)*64);
  double* a561_all = (double*)malloc(nthreads*sizeof(double)*64);

  #pragma omp parallel
  {
    unsigned int th_id = omp_get_thread_num();
    double* a162 = a162_all + th_id*64;
    double* a396 = a396_all + th_id*64;
    double* a561 = a561_all + th_id*64;

  #pragma omp for reduction(+ : d133)

  for (int n134 = 0; n134 < 1048576; n134++) {
    int n141 = n134*15;
    for (int n164 = 0; n164 < 18; n164++) {
      a162[n164] = 0.0;
    }
    int n165 = 1;
    for (int n166 = 0; n166 < 5; n166++) {
      int n167 = (-1)+n165;
      int n170 = (5+n167)%5;
      int n171 = (5+n167)/5;
      int n172 = (n171*5)+n170;
      int n174;
      if (n25==0) {
        n174 = 0;
      } else {
        int n173 = n172%n25;
        n174 = a24[n173];
      }
      int n177 = n174*3;
      int n178 = (-1)+n165;
      int n181 = n178*3;
      int n182 = (-1)+n165;
      int n185 = (10+n182)%5;
      int n186 = (10+n182)/5;
      int n187 = (n186*5)+n185;
      int n189;
      if (n25==0) {
        n189 = 0;
      } else {
        int n188 = n187%n25;
        n189 = a24[n188];
      }
      int n192 = n189*3;
      int n197 = (-1)+n165;
      int n200 = n197%5;
      int n201 = n197/5;
      int n202 = (n201*5)+n200;
      int n204;
      if (n25==0) {
        n204 = 0;
      } else {
        int n203 = n202%n25;
        n204 = a24[n203];
      }
      int n205 = 1+n204;
      int n206 = 1;
      for (int n207 = 0; n207 < 3; n207++) {
        int n209 = (-1)+n206;
        int n212 = (n209+n177)%3;
        int n213 = (n209+n177)/3;
        int n214 = (n213*3)+n212;
        int n215 = (-1)+n165;
        int n218 = (5+n215)%5;
        int n219 = (5+n215)/5;
        int n220 = (n219*5)+n218;
        double d222;
        if (n16==0) {
          d222 = 0.0;
        } else {
          int n221 = n220%n16;
          d222 = a15[n221];
        }
        int n224 = (n209+n181)%3;
        int n225 = (n209+n181)/3;
        int n226 = (n225*3)+n224;
        int n228 = n226%3;
        int n229 = n226/3;
        int n230 = (n228*5)+n229;
        double d238;
        int n231 = n230%5;
        int n233 = n231%5;
        int n234 = n231/5;
        int n235 = (n234*5)+n233;
        double d237;
        if (n16==0) {
          d237 = 0.0;
        } else {
          int n236 = n235%n16;
          d237 = a15[n236];
        }
        d238 = d237;
        double d291;
        int n239 = n226%15;
        int n240 = (n239+n141)%15;
        int n241 = (n239+n141)/15;
        int n242 = (n241*15)+n240;
        int n243 = 0;
        for (int n244 = 0; n244 < 30; n244++) {
          int n246 = (n244+(n242*30))%450;
          int n247 = (n244+(n242*30))/450;
          int n248 = n246%30;
          int n249 = n246/30;
          int n250 = (n247*30)+n248;
          int n251 = (n249*31457280)+n250;
          bool b266;
          int n252 = n251%31457280;
          int n255 = n252%30;
          int n256 = n252/30;
          int n257 = (n255*1048576)+n256;
          int n258 = n257%1048576;
          int n261 = n252%30;
          int n262 = n252/30;
          int n263 = (n261*1048576)+n262;
          int n264 = n263%1048576;
          int n265 = n252%30;
          b266 = !(0==andi(xori((1+n258),shri((1+n264),1)),shli(1,n265)));
          int n268 = (n244+(n242*30))%450;
          int n269 = (n244+(n242*30))/450;
          int n270 = n268%30;
          int n271 = n268/30;
          int n272 = (n270*15)+n271;
          int n273 = (n269*450)+n272;
          int n281;
          int n274 = n273%450;
          int n276 = n274%15;
          int n277 = n274/15;
          int n278 = (n276*30)+n277;
          int n280;
          if (n7==0) {
            n280 = 0;
          } else {
            int n279 = n278%n7;
            n280 = a6[n279];
          }
          n281 = n280;
          n243 = xori(n243,(b2i(b266)*n281));
        }
        double d282 = (i2d(n243)/pow(2.0,30.0))-0.5;
        double d283 = 0.180625-(d282*d282);
        double d284 = d282*((d283*((d283*((d283*((d283*((d283*((d283*((d283*35939.6565123)+67265.770927))+45921.9539315))+13731.6937655))+1971.59095031))+133.141667892))+3.3871328728))/(d283*((d283*((d283*((d283*((d283*((d283*((d283*33955.5810146)+39307.8958001))+21213.7943016))+5394.19602142))+687.187007492))+42.3133307016))+1.0)));
        double d285 = 0.5+(d282*i2d(-((d282<0.0) ? (-1) : 1)));
        double d286 = pow(-ln(d285),0.5);
        double d287 = (-5.0)+d286;
        double d288 = (-1.6)+d286;
        double d289 = (((d288*((d288*((d288*((d288*((d288*((d288*((d288*((7.74545014278*pow(10.0,(-4.0)))+0.0227238449893))+0.241780725177))+1.27045825245))+3.64784832476))+5.76949722146))+4.63033784616))+1.42343711075))/(d288*((d288*((d288*((d288*((d288*((d288*((d288*((1.05075007164*pow(10.0,(-9.0)))+(5.475938085*pow(10.0,(-4.0)))))+0.0151986665636))+0.148103976427))+0.689767334985))+1.67638483018))+2.05319162664))+1.0)))*i2d(b2i(d286<=5.0)))+(((d287*((d287*((d287*((d287*((d287*((d287*((d287*((2.01033439929*pow(10.0,(-7.0)))+(2.71155556874*pow(10.0,(-4.0)))))+0.00124266094739))+0.0265321895266))+0.296560571829))+1.78482653992))+5.46378491116))+6.6579046435))/(d287*((d287*((d287*((d287*((d287*((d287*((d287*((2.04426310339*pow(10.0,(-15.0)))+(1.42151175832*pow(10.0,(-7.0)))))+(1.84631831751*pow(10.0,(-5.0)))))+(7.86869131146*pow(10.0,(-4.0)))))+0.0148753612909))+0.136929880923))+0.599832206556))+1.0)))*i2d(b2i(!(d286<=5.0))));
        double d290 = d289*i2d((d282<0.0) ? (-1) : 1);
        d291 = (d290*i2d(1-b2i(!(0.425<((d282<0.0) ? -d282 : d282)))))+(d284*i2d(b2i(!(0.425<((d282<0.0) ? -d282 : d282)))));
        int n293 = (n209+n192)%3;
        int n294 = (n209+n192)/3;
        int n295 = (n294*3)+n293;
        int n296 = (-1)+n165;
        int n299 = (10+n296)%5;
        int n300 = (10+n296)/5;
        int n301 = (n300*5)+n299;
        double d303;
        if (n16==0) {
          d303 = 0.0;
        } else {
          int n302 = n301%n16;
          d303 = a15[n302];
        }
        int n304 = (-1)+n206;
        int n305 = (((-1)+n205)*3)+n304;
        a162[n305] = (d222*a162[n214])+((d238*d291)+(d303*a162[n295]));
        n206 = 1+n206;
      }
      n165 = 1+n165;
    }
    for (int n397 = 0; n397 < 3; n397++) {
      int n398 = n397*6;
      for (int n399 = 0; n399 < 6; n399++) {
        int n400 = n399+n398;
        int n407 = n400%6;
        int n408 = n400/6;
        int n409 = (n407*3)+n408;
        double d464;
        if (n409<3) {
          int n412 = n409%3;
          int n413 = n409/3;
          int n414 = n412+n413;
          double d416;
          if (n42==0) {
            d416 = 0.0;
          } else {
            int n415 = n414%n42;
            d416 = a41[n415];
          }
          d464 = d416;
        } else {
          int n418 = ((-3)+n409)%3;
          int n419 = ((-3)+n409)/3;
          int n420 = (n418*5)+n419;
          int n422 = n420%5;
          int n423 = n420/5;
          int n424 = (n422*3)+n423;
          double d426;
          if (n59==0) {
            d426 = 0.0;
          } else {
            int n425 = n424%n59;
            d426 = a58[n425];
          }
          double d427 = 0.0;
          for (int n428 = 0; n428 < 3; n428++) {
            int n430 = (n428+(n424*3))%9;
            int n431 = (n428+(n424*3))/9;
            int n432 = n430%3;
            int n433 = n430/3;
            int n434 = (n431*3)+n432;
            int n435 = (n433*15)+n434;
            double d439;
            int n436 = n435%15;
            int n437 = 3+n436;
            double d438;
            if (!(n436<18)) {
              d438 = 0.0;
            } else {
              d438 = a162[n436];
            }
            d439 = a162[n437]-d438;
            int n441 = (n428+(n424*3))%9;
            int n442 = (n428+(n424*3))/9;
            int n443 = n441%3;
            int n444 = n441/3;
            int n445 = (n443*3)+n444;
            int n446 = (n442*9)+n445;
            double d461;
            int n447 = n446%9;
            int n449 = n447%3;
            int n450 = n447/3;
            int n451 = (n449*3)+n450;
            double d453;
            if (n34==0) {
              d453 = 0.0;
            } else {
              int n452 = n451%n34;
              d453 = a33[n452];
            }
            int n456 = n451%3;
            int n457 = n451/3;
            int n458 = (n456*3)+n457;
            int n459 = n458%3;
            int n460 = n451%3;
            d461 = d453*i2d(b2i(!((1+n459)<(1+n460))));
            d427 = d427+(d439*d461);
          }
          double d463;
          if (n50==0) {
            d463 = 0.0;
          } else {
            int n462 = n424%n50;
            d463 = a49[n462];
          }
          d464 = pow(2.71828182846,(d426+(d427*d463)));
        }
        if (n399==0) {
          a396[n400] = d464;
        } else {
          a396[n400] = a396[((-1)+n400)]*d464;
        }
      }
    }
    double a471[] = {3758.05, 11840.0, 1200.0};
    double d509 = HUGE_VAL;
    for (int n510 = 0; n510 < 3; n510++) {
      int n511 = 15+n510;
      int n518 = n511%3;
      int n519 = n511/3;
      int n520 = (n518*6)+n519;
      int n521 = (12+n510)%3;
      d509 = mind(d509,(a396[n520]*(1.0/a471[n521])));
    }
    bool a522[] = {!(d509<0.75), true};
    double d524;
    if (n67==0) {
      d524 = 0.0;
    } else {
      int n523 = 4%n67;
      d524 = a66[n523];
    }
    double d525 = 1e3*d524;
    double d530 = HUGE_VAL;
    for (int n531 = 0; n531 < 3; n531++) {
      int n532 = 15+n531;
      int n539 = n532%3;
      int n540 = n532/3;
      int n541 = (n539*6)+n540;
      int n542 = (12+n531)%3;
      d530 = mind(d530,(a396[n541]*(1.0/a471[n542])));
    }
    double a543[] = {d525, (d530*d525)};
    int n544 = 0;
    for (int n545 = 0; n545 < 7; n545++) {
      bool b560;
      if (n545<5) {
        double d547 = HUGE_VAL;
        for (int n548 = 0; n548 < 3; n548++) {
          int n549 = (n548+(n545*3))+3;
          int n556 = n549%3;
          int n557 = n549/3;
          int n558 = (n556*6)+n557;
          int n559 = (n548+(n545*3))%3;
          d547 = mind(d547,(a396[n558]*(1.0/a471[n559])));
        }
        b560 = !(d547<1.0);
      } else {
        b560 = a522[((-5)+n545)];
      }
      n544 = n544+b2i(b560);
    }
    int n562 = 0;
    for (int n563 = 0; n563 < 7; n563++) {
      bool b578;
      if (n563<5) {
        double d565 = HUGE_VAL;
        for (int n566 = 0; n566 < 3; n566++) {
          int n567 = (n566+(n563*3))+3;
          int n574 = n567%3;
          int n575 = n567/3;
          int n576 = (n574*6)+n575;
          int n577 = (n566+(n563*3))%3;
          d565 = mind(d565,(a396[n576]*(1.0/a471[n577])));
        }
        b578 = !(d565<1.0);
      } else {
        b578 = a522[((-5)+n563)];
      }
      if (b578) {
        double d581;
        if (n563<5) {
          double d580;
          if (n67==0) {
            d580 = 0.0;
          } else {
            int n579 = n563%n67;
            d580 = a66[n579];
          }
          d581 = d580*i2d(1000+(150*(1+n563)));
        } else {
          d581 = a543[((-5)+n563)];
        }
        a561[n562] = d581;
        n562 = 1+n562;
      }
    }
    d133 = d133+a561[0];
  }
  }
  free(a162_all);
  free(a396_all);
  free(a561_all);
  double d582 = d133/1048576.0;
  int n583 = now(1);
  char a584[] = {'R', 'E', 'S', 'U', 'L', 'T', ':', ' '};
  char* a585 = (char*)malloc(sizeof(char)*32);
  formatD(a585,d582);
  int n594 = 8+strlen(a585);
  for (int n595 = 0; n595 < n594; n595++) {
    char c596 = (n595<8) ? a584[n595] : a585[((-8)+n595)];
    printf("%c",c596);
  }
  printf("\n");
  char a597[] = {'T', 'I', 'M', 'I', 'N', 'G', ':', ' '};
  char* a598 = (char*)malloc(sizeof(char)*27);
  sprintf(a598,"%d",(n583-n72));
  int n607 = 8+strlen(a598);
  for (int n608 = 0; n608 < n607; n608++) {
    char c609 = (n608<8) ? a597[n608] : a598[((-8)+n608)];
    printf("%c",c609);
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
