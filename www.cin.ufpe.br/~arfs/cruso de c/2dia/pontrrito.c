#include <stdio.h>

int main() {
    int a = 10, b = 0, *p, *q;

    p = &a;
    a = 12; // *p = 12
    b = *p; // b = 12
    *p = 15; // a = 15
    q = p; // q e p apontam para o mesmo endereço
    *q = 7; // a = 7
    q = &b;
    *q = *p; // b = a = 7
    (*p)++; // a = 8

    printf("a=%d\nb=%d\n*p=%d\n*q=%d\n", a, b, *p, *q);

    return 0;
}
