.model small
.stack

.data

     espera                db 3

     PressionouTecla       dw 0
     varTraz               dw 0
     varFrente             dw 0
     varCima               dw 0
     varBaixo              dw 0
     varEspaco             dw 0


     OldInt15_SEG          dw ? ;guardará a interrupção do teclado
     OldInt15_OFFSET       dw ?


     PONTOX Dw 10
     PONTOY Dw 10
     BALA DB 0
     BALAPOSICAO DB ?
     BALAPOSICAO_TEMP DB ?
     BALAX DW 0
     BALAY DW 0
     SAIRPROGRAMA DW 0
.CODE
include funcao.inc


     DESENHAR_PONTO PROC NEAR

        MOV AH, 00H
        MOV AL, 13H
        INT 10H


        MOV CX, PONTOX
        MOV DX, PONTOY
        MOV AH, 0CH
        MOV AL, 02H
        MOV BH, 00H
        INT 10H

        RET
     DESENHAR_PONTO ENDP

     DESENHAR_BALA PROC NEAR
        CMP BALA, 0
        JE SAIR

        CALL DESLOCAR_BALA
        MOV CX, BALAX
        MOV DX, BALAY
        MOV AH, 0CH
        MOV AL, 02H
        MOV BH, 00H
        INT 10H

        SAIR:
        RET
      DESENHAR_BALA ENDP

      DESLOCAR_BALA PROC NEAR

        CMP BALAPOSICAO, 0
        JE CIMA_BAIXO

        CMP  BALAPOSICAO , 1
        JE BAIXO_CIMA

        CMP  BALAPOSICAO , 2
        JE DIREITA_ESQUERDA

        JMP ESQUERDA_DIREITA

        CIMA_BAIXO:
          add  BALAY, 3
          JMP SAIR_DESLOCAR_BALA
        BAIXO_CIMA:
          sub  BALAY, 3
          JMP SAIR_DESLOCAR_BALA
        DIREITA_ESQUERDA:
          sub  BALAX, 3
          JMP SAIR_DESLOCAR_BALA
        ESQUERDA_DIREITA:
          add  BALAX, 3
          JMP SAIR_DESLOCAR_BALA

        SAIR_DESLOCAR_BALA:
         CALL FIM_BALA
         RET
      DESLOCAR_BALA ENDP

      CRIAR_BALA PROC NEAR

         MOV AL, BALAPOSICAO_TEMP
         MOV BALAPOSICAO, AL
         MOV AX,  PONTOX 
         MOV  BALAX , AX
         MOV AX,  PONTOY
         MOV  BALAY , AX
         MOV  BALA , 1

         RET
      CRIAR_BALA ENDP
      

      FIM_BALA PROC NEAR
        CMP  BALAY , 197
        JGE ELIMINAR

        CMP  BALAY , 3
        JLE ELIMINAR

        CMP  BALAX , 317
        JGE ELIMINAR

        CMP  BALAX , 3
        JLE ELIMINAR

        JMP SAIR_FIM_BALA

        ELIMINAR:
          MOV  BALA , 0
        SAIR_FIM_BALA:
         RET
      FIM_BALA ENDP
START:
      MOV  BALA , 0
      MOV  BALAPOSICAO , 3
      MOV  SAIRPROGRAMA , 0
      MOV  PONTOX , 50
      MOV  PONTOY , 50
      mov espera  ,           3

      CARREGAR_PONTO:
          CMP  SAIRPROGRAMA , 1
          JE SAIR_PRINCIPAL
           ;MOV AH, 00H
           ;MOV AL, 13H
           ;INT 10H
          ;CALL TelaInicio
          CALL SetarInt15
          CALL COMANDO

          JMP CARREGAR_PONTO
      SAIR_PRINCIPAL:
        MOV AX, 00H
        INT 10H
        MOV AH, 04ch
        INT 21H
END START
