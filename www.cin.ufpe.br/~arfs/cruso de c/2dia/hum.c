#include <string.h>
#include <stdio.h>


int main (){

    char strA [200] = {""};
    char strB [200] = {""};
    char conc [1000] = {""};
    int nit = 1;
    int sizBig = 0;
    int sizSmall = 0x8FFFFFFF;
    
   while (nit){

   printf("Entre com uma string qualquer!\n");
   scanf ("%s", strA);
   strcat(conc, strA);
   
   if(strlen (strA) > sizBig){
          sizBig =  strlen (strA);    
   }
   if (strlen (strA) < sizSmall){
          sizSmall = strlen (strA);
      
      }


   printf("Entre com outra string!\n");
   scanf ("%s", strB);
   strcat(conc, strB);
   
      if(strlen (strB) > sizBig){
          sizBig =  strlen (strB);    
   }
      if (strlen (strB) < sizSmall){
          sizSmall = strlen (strB);
      
      }
   
         if ( strcmp(strA, strB) == 0 ){
                  printf("entrou no if\n");
                  printf("voce digitou %s\n", conc);
                  printf("a tamanho da maior string digitada foi %d\n", sizBig);
                  printf("a tamanho da menor string digitada foi %d\n", sizSmall);
                  nit = 0;
   
         }
    
    }

    getche();


}
