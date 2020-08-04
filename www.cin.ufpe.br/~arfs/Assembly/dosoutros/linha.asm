.model small
.stack

.data
     x dw 10
     y dw 0
     TAMANHO DW 0
.code
     START:
           ;CARREGAR AO VIDEO
           MOV AH, 00H
           MOV AL, 13H
           INT 10H

           MOV AX, X
           ADD AX, 20
           MOV TAMANHO, AX

           CARREGAR_PONTO:

           MOV AH, 0CH
           MOV AL, 02H
           MOV BH, 00H
           MOV CX, X
           MOV DX, Y
           INT 10H

           ADD X, 1
           MOV AX, TAMANHO
           CMP X, AX
           JL CARREGAR_PONTO

   
           INT 20H
     END START
