/*programa dos 10 inteiros*/

int main (){

        int num, maior, menor, media, soma, cont, anterior;
        cont = 0;
        menor = 0x0FFFFFFFFF;
        maior = 0;
        soma = 0;
        anterior = 0;
        int continuar = 1;
        
        printf("Digite um numero\n");
        anterior = num;
        scanf("%d", &num);
        cont++;
        soma = soma + num;
        
        while (cont < 10 && continuar){

                printf("Digite outro numero\n");

                anterior = num;
                scanf("%d", &num);
                cont++;
                soma = soma + num;

                if (num > maior){
                      maior = num;
                }

                if(num < menor){
                      menor = num;
                }
                
                if (num == (anterior+1) || cont == 10){

                printf ("a soma eh %d\n", soma);
                printf ("o maior eh %d\n", maior);
                printf ("o menor eh %d\n", menor);
                printf ("o media eh %d\n", (soma/cont));
                continuar = 0;
                getche();
                
                }
        
        }

}
