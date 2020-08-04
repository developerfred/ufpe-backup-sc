/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploPonteiroFuncao.c - Exemplos de como utilizar ponteiros para funções.
 *
 *
 * Exemplo retirado do curso de C da ufmg
 * http://ead1.eee.ufmg.br/cursos/C/
 */

#include <stdio.h>
#include <string.h>

void PrintString(char *str, int (*func)(const char *)) {
	(*func)(str); // chamada a função através do ponteiro para função

	// maneira também válida de se fazer a chamada a função através do
	// ponteiro para função func
	func(str);

}

int main () {
	char String [20]="Curso de C/C++";

	// Declaracao do ponteiro para função Funcao apontada é inteira e recebe
	// como parametro uma string constante
	int (*p)(const char *);

	// O ponteiro p passa a apontar para a função puts
	// que tem o seguinte prototipo: int puts(const char *)
	p=puts;
    p(String);
	PrintString (String, p); // O ponteiro é passado como parametro para PrintString
	return 0;
}
