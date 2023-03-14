#include <stdio.h>

int main(void){

  struct ficha_aluno{
    int numero;
    char nome[40];
    float nota;
  }; // Definicao da struct
  
  struct ficha_aluno a;

  printf("Nome do aluno .....:");
  fgets(a.nome, 40, stdin);

  printf("Digite o numero do aluno: ");
  scanf("%d", &a.numero);

  printf("Digite a nota do aluno: ");
  scanf("%f", &a.nota);

  printf("Nome ....... : %s", a.nome);
  printf("Numero ......: %d \n", a.numero);
  printf("Nota.........: %.2f \n", a.nota);
  return 0;
}