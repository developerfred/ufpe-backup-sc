#include <stdio.h>

int main() {
    int numeros[10] = {1, 1};
    int i;

    for (i = 2; i < 10; i++) {
        numeros[i] = numeros[i-1] + numeros[i-2];
    }

    for (i = 0; i < 10; i++) {
        printf("%d\n", numeros[i]);
    }

    getche();

    return 0;
}
