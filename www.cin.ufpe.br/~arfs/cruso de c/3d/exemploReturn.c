/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploReturn.c - Mostra um exemplo de como utilizar a palavra reservada return
 * dentro de funções
 */

#include <stdio.h>

int dividir(int a, int b) {
	if (!b) return 0;

	return a / b;

}

int main() {
	printf("12 / 2 = %d\n", dividir(12, 2));
	printf(" 1 / 0 = %d\n", dividir(1, 0));
	return 0;
}
