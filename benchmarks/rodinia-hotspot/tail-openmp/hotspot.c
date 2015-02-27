#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <apl.h>
#include <omp.h>
double kernel(int n171) {
  char a1[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 't', 'e', 'm', 'p', '_', '5', '1', '2'};
  char* a2 = (char*)malloc(sizeof(char)*17);
  for (int n4 = 0; n4 < 16; n4++) {
    a2[n4] = a1[n4];
  }
  a2[16] = '\000';
  int* a5 = (int*)malloc(sizeof(int)*1);
  double* a6 = readDoubleVecFile(a2,a5);
  int n7 = a5[0];
  char a10[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'p', 'o', 'w', 'e', 'r', '_', '5', '1', '2'};
  char* a11 = (char*)malloc(sizeof(char)*18);
  for (int n13 = 0; n13 < 17; n13++) {
    a11[n13] = a10[n13];
  }
  a11[17] = '\000';
  int* a14 = (int*)malloc(sizeof(int)*1);
  double* a15 = readDoubleVecFile(a11,a14);
  int n16 = a14[0];
  int n18 = now(0);
  int n33 = 262144;
  double* a32 = (double*)malloc(sizeof(double)*262144);
  for (int n34 = 0; n34 < 262144; n34++) {
    double d173;
    if (n7==0) {
      d173 = 0.0;
    } else {
      int n172 = n34%n7;
      d173 = a6[n172];
    }
    a32[n34] = d173;
  }
  for (int n60 = 0; n60 < 360; n60++) {
    double* a57 = (double*)malloc(sizeof(double)*262144);
    #pragma omp parallel for shared(a57) schedule(static)
    for (int n59 = 0; n59 < 262144; n59++) {
      double d62;
      if (n16==0) {
        d62 = 0.0;
      } else {
        int n61 = n59%n16;
        d62 = a15[n61];
      }
      int n63 = n59%512;
      int n64 = n59/512;
      int n65 = (n64*512)+n63;
      double d74;
      if (n65<261632) {
        int n66 = n65%512;
        int n67 = n65/512;
        int n68 = (n67*512)+n66;
        int n69 = 512+n68;
        d74 = a32[n69];
      } else {
        d74 = 0.0;
      }
      int n75 = (n64*512)+n63;
      double d84;
      if (n75<512) {
        d84 = 0.0;
      } else {
        int n79 = (-512)+n75;
        int n80 = n79%512;
        int n81 = n79/512;
        int n82 = (n81*512)+n80;
        d84 = a32[n82];
      }
      int n85 = n59%512;
      int n86 = n59/512;
      int n87 = (n86*512)+n85;
      int n103;
      if (n87<512) {
        n103 = 1;
      } else {
        int n91 = (-512)+n87;
        int n92 = n91%512;
        int n93 = n91/512;
        int n94 = (n93*512)+n92;
        int n102 = (n94<261120) ? 2 : 1;
        n103 = n102;
      }
      int n104 = n59%512;
      int n105 = n59/512;
      int n106 = (n104*512)+n105;
      double d118;
      if (n106<261632) {
        int n107 = n106%512;
        int n108 = n106/512;
        int n109 = (n108*512)+n107;
        int n110 = 512+n109;
        int n111 = n110%512;
        int n112 = n110/512;
        int n113 = (n111*512)+n112;
        d118 = a32[n113];
      } else {
        d118 = 0.0;
      }
      int n119 = (n104*512)+n105;
      double d131;
      if (n119<512) {
        d131 = 0.0;
      } else {
        int n123 = (-512)+n119;
        int n124 = n123%512;
        int n125 = n123/512;
        int n126 = (n125*512)+n124;
        int n128 = n126%512;
        int n129 = n126/512;
        int n130 = (n128*512)+n129;
        d131 = a32[n130];
      }
      int n132 = n59%512;
      int n133 = n59/512;
      int n134 = (n132*512)+n133;
      int n150;
      if (n134<512) {
        n150 = 1;
      } else {
        int n138 = (-512)+n134;
        int n139 = n138%512;
        int n140 = n138/512;
        int n141 = (n140*512)+n139;
        int n149 = (n141<261120) ? 2 : 1;
        n150 = n149;
      }
      a57[n59] = a32[n59]+(0.341333333333*(d62+((((d74+d84)-(i2d(n103)*a32[n59]))/10.0)+((((d118+d131)-(i2d(n150)*a32[n59]))/10.0)+((80.0-a32[n59])/5120.0)))));
    }
    free(a32);
    a32 = a57;
    n33 = 262144;
  }
  int n151 = now(1);
  char a152[] = {'R', 'E', 'S', 'U', 'L', 'T', ':', ' '};
  double d153 = -HUGE_VAL;
  for (int n154 = 0; n154 < 512; n154++) {
    double d155 = -HUGE_VAL;
    for (int n156 = 0; n156 < 512; n156++) {
      int n157 = n156+(n154*512);
      d155 = maxd(d155,a32[n157]);
    }
    d153 = maxd(d153,d155);
  }
  char* a158 = (char*)malloc(sizeof(char)*32);
  formatD(a158,d153);
  int n159 = 8+strlen(a158);
  for (int n161 = 0; n161 < n159; n161++) {
    char c163;
    if (n161<8) {
      c163 = a152[n161];
    } else {
      int n162 = (-8)+n161;
      c163 = a158[n162];
    }
    printf("%c",c163);
  }
  printf("\n");
  char a164[] = {'T', 'I', 'M', 'I', 'N', 'G', ':', ' '};
  char* a165 = (char*)malloc(sizeof(char)*27);
  sprintf(a165,"%d",(n151-n18));
  int n166 = 8+strlen(a165);
  for (int n168 = 0; n168 < n166; n168++) {
    char c170;
    if (n168<8) {
      c170 = a164[n168];
    } else {
      int n169 = (-8)+n168;
      c170 = a165[n169];
    }
    printf("%c",c170);
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
