; modelo da mem�ria
.model small

;definindo o tamanha da pilha
.stack

;declarando vari�veis
.data
   x dw 10
   y dw 0
   w dw 10

;o codigo em si
.code
     
     ;nunca se esque�a de colocar isso
     START:
     
     INICAILIZAR:
           
            mov [w], 20
            mov [x], 10
            mov [y], 0

           ;chama a interrup��o de video
           ;poderia ser assim tb
           ;MOV AH, 00H
           ;MOV AL, 13H
           ;int 10H � a interrup��o de
           ;videop q vai no reg AX para ver qual ser� a resolu��o
           ;no caso 320x200 a 256 cores
           MOV AX, 13H
           INT 10H

               ;nova posi��o x
               MOV CX, [x]
               ;nova posi��o y
               MOV DX, [y]
           CARREGAR_PONTO:

               mov AX, 13h
               int 10H

               ;cai do ceu para desenhar um pixel
               MOV AH, 0CH
               ;cor do pixel
               MOV AL, 02H
               ;????
               MOV BH, 00H
               ;repaint
               INT 10H

               ;esperando uma tecla
               MOV AX, 00H
               INT 16H

               CMP AH, 4DH
               JE DIREITA

               CMP AH, 4BH
               JE ESQUERDA

               CMP AH, 48H
               JE BAIXO

               CMP AH, 50H
               JE CIMA

               jmp SAIR

               DIREITA:
                  INC CX
                  JMP CARREGAR_PONTO

               ESQUERDA:
                  DEC CX
                  JMP CARREGAR_PONTO

               CIMA:
                  INC DX
                  JMP CARREGAR_PONTO

               BAIXO:
                  DEC DX
                  JMP CARREGAR_PONTO

           SAIR:
                mov ah, 31
                INT 21H
     END START
