.MODEL SMALL

.STACK 200h

.CODE

START:

MOV AX, 0A000h ; o segmento do VGA vai para um registrador

MOV ES, AX ; de segmento (ES)

MOV BX, 32160 ; plota na posi��o (159,99)

MOV DI, BX

MOV AL, 54 ;cor a ser plotada

MOV ES:[DI], AL ;[ ] significa que estamos movendo para o

;local de mem�ria indicado por DI, e n�o para o registrador DI.

END START