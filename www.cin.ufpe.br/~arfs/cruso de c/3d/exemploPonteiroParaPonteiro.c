/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Inform�tica - CIn
 * Centro Integrado de Tecnologia da Informa��o - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploPonteiroParaPonterio.c - Exemplos de como utilizar ponteiros para 
 * ponteiros.
 */

#include <stdio.h>

int main() {
	int a = 10, *p, **pp;

	p = &a;
	pp = &p;

	// imprime 10
	printf("%d\n", **pp);
	return 0;
}
