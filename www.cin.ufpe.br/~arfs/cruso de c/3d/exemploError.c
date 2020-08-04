/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Informática - CIn
 * Centro Integrado de Tecnologia da Informação - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploError.c - Mostra como utilizar a diretiva de compilação #error
 */

int main() {

    // _WIN32 é uma diretiva que os compiladores usam para indicar que são
    // do  windows
    #ifndef __linux__
        #error Este programa so compila no Linux
    #endif

}
