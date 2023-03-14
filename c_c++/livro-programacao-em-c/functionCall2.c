#include <stdio.h>
void imp_ini(void){
  printf("Impressao do cabecalho\n");
}
void imp_fim(void){
  printf("Fim de programa\n");
}

int main(void){
  int x;
  imp_ini();
  scanf("%d", &x);
  printf("Dobro = %d\n", (2*x));
  imp_fim();
  return 0;
}


