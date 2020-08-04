/*
 * Universidade Federal de Pernambuco - UFPE
 * Centro de Inform�tica - CIn
 * Centro Integrado de Tecnologia da Informa��o - CITi
 * Curso de C/C++
 * Instrutor: Allan Lima - adsl@cin.ufpe.br
 *
 * exemploError.c - Mostra como utilizar a diretiva de compila��o #error
 */

int main() {

    // _WIN32 � uma diretiva que os compiladores usam para indicar que s�o
    // do  windows
    #ifndef __linux__
        #error Este programa so compila no Linux
    #endif

}
