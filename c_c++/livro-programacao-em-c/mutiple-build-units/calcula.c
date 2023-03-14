#include <math.h>

extern double a, b, c, delta, r1, r2;
void calcula_delta(void){
  delta = pow(b, 2.0) - 4.0 * a * c;
}

void calcula_raizes(void){
  calcula_delta();

  if(delta >= 0.0){
    r1 = (-b + sqrt(delta)) / (2 * a);
    r2 = (-b - sqrt(delta)) / (2 * a);
  }
}