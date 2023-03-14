#include <stdio.h>
#include <math.h>

int main(void){
  double a, b, c, delta, r1, r2;
  printf("Digite o coeficiente a: ");
  scanf("%lf", &a);
  
  printf("Digite o coeficiente b: ");
  scanf("%lf", &b);
  
  printf("Digite o coeficiente c: ");
  scanf("%lf", &c);

  delta = pow(b,2) - 4 * a * c;
  if(delta >= 0.0){
    r1 = (-b + sqrt(delta)) / (2 * a);
    
    r2 = (-b - sqrt(delta)) / (2 * a);
  }

  if(delta >= 0.0){
    printf("Raiz r1 = %f\n", r1);
    printf("Raiz r2 = %f\n", r2);
  }else{
    printf("Sem raizes reais\n");
  }

  return 0;
  
}