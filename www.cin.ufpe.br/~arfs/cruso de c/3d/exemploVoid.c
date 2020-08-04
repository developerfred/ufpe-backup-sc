/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploVoid.c - Exemplos de como utilizar ponteiros para void
 */


#include <stdio.h>

int main() {
	char *s = "string";
	int a = 1, *p = &a;
	float f = 2.0;
	void *v;

	v = p; // v aponta para um inteiro
	printf("%d\n", *((int *) v));
	v = s; // v aponta para uma string
	printf("%s\n", (char *) v);
	v = &f; // v aponta para um float
	printf("%f\n", *((float *) v));

	return 0;
}
