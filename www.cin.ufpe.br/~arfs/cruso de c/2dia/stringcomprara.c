#include <stdio.h>
#include <string.h>

int main() {
    char pergunta[] = "Qual é a sua linguagem favorita? ";
    char resposta[15];

    do {
        puts(pergunta);
        printf("%s", pergunta);
        scanf("%s", resposta);
       
     
       
    } while (strcmp(resposta, "C/C++"));
    
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
