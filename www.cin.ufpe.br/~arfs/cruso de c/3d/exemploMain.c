/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploMain.c - Mostra um exemplo de como utilizar os parâmetros da função main.
 */

#include <stdio.h>

int main (int argc, char *argv[]) {
	int i;

	for (i = 0; i < argc; i++) {
		printf("%s\n", argv[i]);
	}

	printf("total: %d\n", argc);
	getche();
	return 0;
}
