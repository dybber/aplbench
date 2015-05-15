#include <stdio.h>
#include <sys/time.h>

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

int main() {
  initialize();
  int t0 = now(0);
  double result = 0.0;
  for (int i = 0; i < 10; i++) {
    double sum = 0.0;
    const double dx = 1e-6;
    double x = dx;
    for (int j = 0; j < 10000000; j++) {
      x += dx;
      sum = sum+(2.0/(x+2.0));
    }
    result = dx*sum;
  }
  int t1 = now(1);
  int delta = t1-t0;
  double avg = ((double)delta)/10.0;
  printf("ITERATIONS: %d\n",10);
  printf("TIMING: %d\n",delta);
  printf("AVGTIMING: %g\n",avg);
  printf("RESULT: %f\n",result);
  return 0;
}
