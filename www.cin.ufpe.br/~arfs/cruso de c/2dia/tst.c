#include <string.h>

int main (){

    char origem [] = {"Rodrigo"};
    char destino [] = {"Santana"};
    
    strcpy (destino, origem);
    
    printf("%s", destino);
    getche();
    
    return 0;


}

/*int main() {
    char string[20];

    printf("Digite uma string: ");
    gets(string);
    printf("Voce digitou: ");
    puts(string);

    // forma portável de subtituir o system("pause");
    getchar();
    return 0;
}*/
