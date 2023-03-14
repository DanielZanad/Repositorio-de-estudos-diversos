#include <stdio.h>
#include <math.h>

int main(void){
  double x, r, p;
  scanf("%lf", &x);
  r = sqrt(x);
  p = pow(x,3);
  printf("Raiz de %f = %f\n", x, r);
  printf("Cubo de %f = %f\n", x, p);
  return 0;

}