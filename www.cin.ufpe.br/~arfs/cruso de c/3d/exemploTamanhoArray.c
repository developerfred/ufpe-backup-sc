/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploTamanhoArray.c - Demonstra como descobrir o tamanho de uma array em
 *                         tempo de execução.
 */

#include <stdio.h>

int main() {
    int a[10], tamanho;
    float f[20];

    tamanho = sizeof(a) / sizeof(int);
    printf("Tamanho de a: %d\n", tamanho);
    tamanho = sizeof(f) / sizeof(float);
    printf("Tamanho de f: %d\n", tamanho);

    return 0;
}
