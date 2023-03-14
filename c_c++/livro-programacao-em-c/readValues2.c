#include <stdio.h>

int main(void){
  int x, y;
  printf("Primeiro valor inteiro: ");
  scanf("%d", &x);
  printf("Segundo valor inteiro: ");
  scanf("%d", &y);

  printf("Soma = %d \n", x + y);
  return 0;
}