.MODEL SMALL

.STACK 200h

.CODE


START:

MOV AH, 00h

MOV AL, 13h

INT 10h

MOV AL, 00h

INT 10h

MOV AX, 4C00h

INT 21h

END START