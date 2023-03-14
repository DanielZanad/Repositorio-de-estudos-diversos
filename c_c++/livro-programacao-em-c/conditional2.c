#include <stdio.h>

int main(void){
  double a,b;
  scanf("%lf", &a);
  scanf("%lf", &b);
  printf("Equacao: %fx + %f = 0 \n", a ,b);
  if( a == 0.0){
    printf("Nao existe raiz\n");
  }else{
    printf("Raiz = %f \n", (-b / a));
  }
  return 0;
}