#include <stdio.h>

double a, b, c, delta, r1, r2;
void ler_dados(void){
  printf("Digite o coeficiente a: ");
  scanf("%lf", &a);
  
  printf("Digite o coeficiente b: ");
  scanf("%lf", &b);
  
  printf("Digite o coeficiente c: ");
  scanf("%lf", &c);
}

void imp_resultado(void){
  if(delta >= 0.0){
    printf("Raiz r1 = %f\n", r1);
    printf("Raiz r2 = %f\n", r2);
  }else{
    printf("Sem raizes reais\n");
  }
}