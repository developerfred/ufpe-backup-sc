/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Inform�tica - CIn
 * Centro Integrado de Tecnologia da Informa��o - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * respostaExercicios.c - Resposta ao terceiro exerc�cio da 3� aula
 */

#include <stdio.h>

#define min(a, b) (a > b) ? b : a
#define isPar(a) (a%2) ? 0 : 1


int main () {
	printf("10 eh par ? %d\n", isPar(10));
	printf("3 eh par ? %d\n", isPar(3));

	printf("min(18, 9) = %d\n", min(18, 9));
	printf("min(7, 45) = %d\n", min(7, 45));
}
