/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Inform�tica - CIn
 * Centro Integrado de Tecnologia da Informa��o - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploPrototipo.c - Exemplos de como utilizar port�tipos de fun��es
 */

void b(int); //pr�totipo de b

void a(int i) {
    b(i);
}

void b(int i) {
    a(i);
}

int main() {
    return 0;
}
