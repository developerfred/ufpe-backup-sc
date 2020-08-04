.model small
.stack

.data
   valorX1 dw 0000H
   valorY1 dw 0000H
   valorX2 dw 0000H
   valorY2 dw 0000H
   PONTO DB 00H
.code
     START:
           MOV [valorX1], 0
           MOV [valorY1], 0
           MOV [valorX2], 100
           MOV [valorY2], 100
           mov [ponto], 0

           CARREGAR_PONTOS:

           MOV AH, 00H
           MOV AL, 13H
           INT 10H

           ;CARREGAR_PONTO:
               ;desenha primeiro ponto
                   MOV CX, [VALORX1]
                   MOV DX, [VALORY1]
                   MOV AH, 0CH
                   MOV AL, 02H
                   MOV BH, 00H
                   INT 10H
                ; desenha segundo ponto
                   MOV CX, [VALORX2]
                   MOV DX, [VALORY2]
                   MOV AH, 0CH
                   MOV AL, 02H
                   MOV BH, 00H
                   INT 10H

               MOV AH, 00H
               INT 16H
               ;PLAYER 1
               ;CMP AH, 4DH
               ;JE DIREITA1

               ;CMP AH, 4BH
               ;JE ESQUERDA1

               ;CMP AH, 48H
               ;JE CIMA1

               ;CMP AH, 50H
               ;JE BAIXO1
               ;PLAYER 2

               CMP AX, 2064H
               JE DIREITA2

               CMP AX, 1E61H
               JE ESQUERDA2

               CMP AX, 1177H
               JE CIMA2

               CMP AX, 1F73H
               JE BAIXO2

               JMP TEXTO

               DIREITA1:
                 MOV CX, [VALORX1]
                 MOV DX, [VALORY1]
                  INC CX
                  JMP MOVER_1
               ESQUERDA1:
                 MOV CX, [VALORX1]
                 MOV DX, [VALORY1]
                  DEC CX
                  JMP MOVER_1
               CIMA1:
                 MOV CX, [VALORX1]
                 MOV DX, [VALORY1]
                  dec DX
                  JMP MOVER_1
               BAIXO1:
                 MOV CX, [VALORX1]
                 MOV DX, [VALORY1]
                  inc DX
                  JMP MOVER_1


               DIREITA2:
                  MOV CX, [VALORX2]
                  MOV DX, [VALORY2]
                  INC CX
                  JMP MOVER_2
               ESQUERDA2:
               MOV CX, [VALORX2]
                  MOV DX, [VALORY2]
                  DEC CX
                  JMP MOVER_2
               CIMA2:
               MOV CX, [VALORX2]
                  MOV DX, [VALORY2]
                  dec DX
                  JMP MOVER_2
               BAIXO2:
               MOV CX, [VALORX2]
                  MOV DX, [VALORY2]
                  inc DX
                  JMP MOVER_2

               MOVER_1:
                 MOV [VALORX1], CX
                 MOV [VALORY1], DX

                 JMP CARREGAR_PONTOS

                MOVER_2:
                 MOV [VALORX2], CX
                 MOV [VALORY2], DX
                 JMP CARREGAR_PONTOS

            TEXTO:
                MOV AH, 00H
                MOV AL, 00H
                INT 10H
                INT 20H
     END START
