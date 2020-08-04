/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploPrototipo.c - Exemplos de como utilizar portótipos de funções
 */

void b(int); //prótotipo de b

void a(int i) {
    b(i);
}

void b(int i) {
    a(i);
}

int main() {
    return 0;
}
