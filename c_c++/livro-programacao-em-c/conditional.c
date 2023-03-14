#include <stdio.h>

int main(void)
{
  int x, y;
  scanf("%d", &x);
  scanf("%d", &y);
  printf("O maior numero digitado foi: \n");
  if (x > y)
    printf("%d", x);
  else
    printf("%d", y);

  return 0;
}