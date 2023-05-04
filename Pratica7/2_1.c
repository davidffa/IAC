#include <stdio.h>

int main(void) {
  int sum = 0;
  int n;

  for (int i = 0; i < 5; ++i) {
    printf("Escreva um número: ");
    scanf("%d", &n);

    sum += n;
  }

  printf("A soma dos números é: %d\n", sum);

  return 0;
}