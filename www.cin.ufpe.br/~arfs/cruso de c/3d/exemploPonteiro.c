/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploPonteiro.c - Mostra um exemplo de como utilizar poteiros para percorrer
 * uma matriz bidimensional.
 */

#include <stdio.h>
int main() {
	int mat[50][50];
	int *p=mat, i;

	for (i = 0; i < 2500; i++) {
		*p = 0;
		p++;
	}

	return 0;
}
