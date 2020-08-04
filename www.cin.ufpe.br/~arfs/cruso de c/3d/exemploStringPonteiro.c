/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploStringPonteiro.c - Mostra um exemplo de como utilizar um ponteiro como string
 */

#include <stdio.h>
#include <string.h>

int main() {
	char curso[15];
	char *p = "Curso de C/C++";

	strcpy(curso, p);
	printf("%s %s\n", curso, p);

	return 0;
}
