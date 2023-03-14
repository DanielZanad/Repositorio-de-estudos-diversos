#include <stdio.h>

int x; // Declarando uma variavel do tipo int com o nome x em um escopo global

void lerdados(void){
  printf("Digite um valor inteiro: ");
  scanf("%d", &x);
}
void impdados(void){
  printf("Dobro = %d\n", (2 * x));
}
int main(void){
  impdados();
  lerdados();
  printf("fim programa\n");
  return 0;
}
