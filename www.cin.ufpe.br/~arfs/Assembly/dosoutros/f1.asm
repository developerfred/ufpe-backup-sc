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

           CARREGAR_PONTO:

               ;cai do ceu para desenhar um pixel
               MOV AH, 0CH
               ;cor do pixel
               MOV AL, 02H
               ;????
               MOV BH, 00H
               ;nova posi��o x
               MOV CX, [x]
               ;nova posi��o y
               MOV DX, [y]
               ;repaint
               INT 10H

           REPETIR:
               ;incrementando o y
               mov ax, [x]
               add ax, 1
               mov [x], ax

               mov ax, [x]
               ;mov bx, [w]

               ;comparando para fazer o pulo condicional
               cmp [w],ax
               jne CARREGAR_PONTO

               jmp SAIR

           SAIR:
                INT 20H
     END START
