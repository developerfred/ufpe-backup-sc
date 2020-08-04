DOSSEG
.MODEL SMALL
.STACK 200h
.DATA

Pergunta DB "vC GOSTA DE MULHER??$"

Sim DB "MENTIROSO!!$"

Nao DB "VIADAO, BOIOLA, PUTO!!!!$"

.CODE

START:

MOV AX, SEG Pergunta
MOV DS, AX

DeNovo:

MOV DX, OFFSET Pergunta
MOV AH, 9h
INT 21h

MOV AH, 0h
INT 16h
CMP AX, "S"
JNE MauAluno

MOV AH, 9h
MOV DX, OFFSET SiM
INT 21H
MOV AX, 4c00h
INT 21h

MauAluno:

MOV AH ,9h
MOV DX, OFFSET Nao
INT 21h

JUMP DeNovo

END START