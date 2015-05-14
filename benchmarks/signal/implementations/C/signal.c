#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <sys/time.h>

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

struct timeval tv_init;
static void initialize() {
  gettimeofday(&tv_init, NULL);
  return;
}
// return time since process start in milliseconds
static int now (int x) {
  struct timeval tv_check;
  gettimeofday(&tv_check, NULL);
  long int usec = tv_check.tv_usec - tv_init.tv_usec;
  long int sec = tv_check.tv_sec - tv_init.tv_sec;
  long int msec = usec / 1000;
  return (int)(sec*1000+msec);
}

double kernel(int n18) {
  int n0 = now(0);
  double d1 = 0.0;
  for (int n2 = 0; n2 < 30; n2++) {
    double d3 = 0.0;
    double d7 = 0.0;
    for (int n4 = 0; n4 < 10000000; n4++) {
      double d13 = d7;
      d7 = sin((double)(1+n4)/1e6);
      d3 = d3+MAX((-50.0),MIN(50.0,(50.0*((d7-d13)/(0.01+sin((double)(1+n4)/1e6))))));
    }
    d1 = d3;
  }
  int n15 = now(1);
  int n16 = n15-n0;
  double d17 = (double)(n16)/30.0;
  printf("ITERATIONS: %d\n",30);
  printf("TIMING: %d\n",n16);
  printf("AVGTIMING: %g\n",d17);
  printf("RESULT: %f\n",d1);
  return d1;
}

int main() {
  initialize();
  printf("%f", kernel(0));
  printf("\n");
  return 0;
}
