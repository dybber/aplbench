#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "include/apl.h"
double kernel(int n149) {
  char a1[] = {'.', '.', '/', 'd', 'a', 't', 'a', '/', 'd', 'i', 'r', 'e', 'c', 't', 'i', 'o', 'n', '_', 'v', 'e', 'c', 't', 'o', 'r', 's'};
  char* a2 = (char*)malloc(sizeof(char)*26);
  for (int n4 = 0; n4 < 25; n4++) {
    a2[n4] = a1[n4];
  }
  a2[25] = '\000';
  int* a5 = (int*)malloc(sizeof(int)*1);
  int* a6 = readIntVecFile(a2,a5);
  int n7 = a5[0];
  int n71 = now(0);
  int n76 = 0;
  #pragma omp parallel reduction(+ : n76)
  {
  #pragma omp for
  for (int n77 = 0; n77 < 10000000; n77++) {
    double d78 = 0.0;
    for (int n79 = 0; n79 < 2; n79++) {
      int n80 = 0;
      for (int n81 = 0; n81 < 30; n81++) {
        int n83 = (n81+((n79+(n77*2))*30))%60;
        int n84 = (n81+((n79+(n77*2))*30))/60;
        int n85 = n83%30;
        int n86 = n83/30;
        int n87 = (n84*30)+n85;
        int n88 = (n86*300000000)+n87;
        bool b103;
        int n89 = n88%300000000;
        int n92 = n89%30;
        int n93 = n89/30;
        int n94 = (n92*10000000)+n93;
        int n95 = n94%10000000;
        int n98 = n89%30;
        int n99 = n89/30;
        int n100 = (n98*10000000)+n99;
        int n101 = n100%10000000;
        int n102 = n89%30;
        b103 = !(0==andi(xori((1+n95),shri((1+n101),1)),shli(1,n102)));
        int n105 = (n81+((n79+(n77*2))*30))%60;
        int n106 = (n81+((n79+(n77*2))*30))/60;
        int n107 = n105%30;
        int n108 = n105/30;
        int n109 = (n107*2)+n108;
        int n110 = (n106*60)+n109;
        int n120;
        int n111 = n110%60;
        int n113 = n111%2;
        int n114 = n111/2;
        int n115 = (n113*30)+n114;
        int n119;
        int n116 = n115%450;
        int n118;
        if (n7==0) {
          n118 = 0;
        } else {
          int n117 = n116%n7;
          n118 = a6[n117];
        }
        n119 = n118;
        n120 = n119;
        n80 = xori(n80,(b2i(b103)*n120));
      }
      d78 = d78+pow((i2d(n80)/pow(2.0,30.0)),2.0);
    }
    n76 = n76+b2i(!(1.0<=pow(d78,0.5)));
  }
  }
  double d121 = 4.0*(i2d(n76)/1e7);
  int n122 = now(1);
  char a123[] = {'R', 'E', 'S', 'U', 'L', 'T', ':', ' '};
  char* a124 = (char*)malloc(sizeof(char)*32);
  formatD(a124,d121);
  int n133 = 8+strlen(a124);
  for (int n134 = 0; n134 < n133; n134++) {
    char c135 = (n134<8) ? a123[n134] : a124[((-8)+n134)];
    printf("%c",c135);
  }
  printf("\n");
  char a136[] = {'T', 'I', 'M', 'I', 'N', 'G', ':', ' '};
  char* a137 = (char*)malloc(sizeof(char)*27);
  sprintf(a137,"%d",(n122-n71));
  int n146 = 8+strlen(a137);
  for (int n147 = 0; n147 < n146; n147++) {
    char c148 = (n147<8) ? a136[n147] : a137[((-8)+n147)];
    printf("%c",c148);
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
