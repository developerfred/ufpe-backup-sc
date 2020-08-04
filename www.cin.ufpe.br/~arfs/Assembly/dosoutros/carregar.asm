.model small
.386
.stack
.data

palleteBuffer           db     768   dup(?)
buffertanque   db    2640 dup(?)

;paletaMenu   db     'tanke1.pal', 0
;datMenu      db     'tanke1.dat', 0

paletatanque   db     'tanke1.pal',0
dattanque      db     'tanke1.dat',0
tanke2_paleta	db    'tanke2.pal',0
tanke2_dat	db    'tanke2.dat',0

TANKX      DB 0
TANKY      DB 0
SAIRPROGRAMA DB 0


.code

COMANDO PROC NEAR

         MOV AH, 00H
         INT 16H

         CMP AX, 1177H
         JE CIMA

         CMP AX, 1E61H
         JE ESQUERDA

         CMP AX, 1F73H
         JE BAIXO

         CMP AX, 2064H
         JE DIREITA


         CMP AX, 1071H
         JE SAIR_PROGRAMA


         JMP SAIR_COMANDO

         CIMA:
            DEC [TANKX]

            JMP SAIR_COMANDO
         BAIXO:
            INC [TANKX]

            JMP SAIR_COMANDO
         ESQUERDA:

            DEC[TANKY]
            JMP SAIR_COMANDO
         DIREITA:

            INC [TANKY]
            JMP SAIR_COMANDO

         SAIR_PROGRAMA:
           MOV [SAIRPROGRAMA], 1

         SAIR_COMANDO:
           MOV AX, 00H
           RET
      COMANDO ENDP

start:
        MOV [SAIRPROGRAMA], 0
        MOV [TANKX], 10
        MOV [TANKY], 100
        mov ax, @data
        mov ds, ax

        DESENHA:

        xor ah, ah
        mov al, 13h
        int 10h

        call TelaInicio

        CMP [SAIRPROGRAMA], 0
        JE DESENHA
        xor ah, ah
        mov al, 03h
        int 10h

        mov ax, 4C00h
        int 21h


;=====================================================;
; .: Procedimento TelaInicio                          ;
;-----------------------------------------------------;
;    -> Desenha Tela de Inicio                        ;
;=====================================================;
TelaInicio PROC NEAR

        pusha

        ; DS, ES apontam para o segmento de dados
        mov ax, @data
        mov ds, ax
        mov es, ax

        ; limpa a tela
        mov ax, 0
        call ClearScreen

	; Carrega a paleta de cores
        ; mov dx, offset paletaMenu
        ; call LoadPallete

	 ; Exibe a imagem de menu
         ;mov dx, offset datMenu
         ;call DrawBack




        ; Lê a imagem do tanque do arquivo
        mov dx, offset dattanque
        mov ax, ds
        mov es, ax
        mov di, offset buffertanque
        mov cx, 2640
        call ReadFile

        ; carrega a paleta do tanque
        mov dx, offset paletaTanque
        call LoadPallete

        ; Define posição do tanque
        mov bh, [TANKY]
        mov bl, [TANKX]
        mov cx, 60
        mov dx, 44

        ; Carrega offset do tanque
        mov si, offset buffertanque
        ; Chama procedimento para desenhar
        call DrawGraphics


	;tanke2
	;mov dx, offset tanke2_dat
	;mov ax, ds
	;mov es,ax
	;mov di, offset buffertanque
	;mov cx,2640
	;call Readfile

	;mov dx, offset tanke2_paleta
	;call LoadPallete

	;mov bh,70
	;mov bl,140
	;mov cx,60
	;mov dx,44

	;mov si, offset bufferTanque
	;call DrawGraphics

        
        ; espera alguma tecla ser digitada
        xor ah, ah
        int 16h

        ; limpa a tela
        mov ax, 0
        call ClearScreen

        popa
        ; Final do procedimento TelaInicio
       CALL COMANDO
        ret

TelaInicio ENDP





;=====================================================;
; .: Procedimento ClearScreen                         ;
;-----------------------------------------------------;
;    -> Preenche a tela com a cor especificada        ;
;-----------------------------------------------------;
;    Parâmetros: AX      Cor                          ;
;=====================================================;
ClearScreen    PROC   NEAR

        ; Empilha Registradores
        pusha
        push ds es

        ; Zera DirectionFlag - faz DI incrementar apos STOSB
        cld

        ; Copia AX (320x200) vezes na Memoria de Video
        mov dx, 0A000h
        mov es, dx
        mov di, 0
        mov cx, 64000
        rep stosb

        ; Desempilha Registradores
        pop es ds
        popa
        ; Final do procedimento ClearScreen
        ret

ClearScreen    ENDP

;=====================================================;
; .: Procedimento LoadPallete                         ;
;-----------------------------------------------------;
;    -> Carrega a paleta de cores                     ;
;-----------------------------------------------------;
;    Parâmetros: DS:DX    Nome do arquivo da paleta   ;
;                         (ASCII%)                    ;
;=====================================================;
LoadPallete     PROC   NEAR

        ; Empilha todos os registradores
        pusha
        push ds es

        ; Lê o arquivo de paleta para o buffer
        mov ax, @data
        mov es, ax
        mov di, offset palleteBuffer
        mov cx, 768
        call ReadFile

        ; Ativa escrita da paleta (porta 3C8h)
        mov dx, 3C8h
        xor al, al
        out dx, al

        ; Entrada de valores da paleta (porta 3C9h)
        inc dx

        ; Envia 768 Bytes do buffer para a paleta
        mov si, offset palleteBuffer
        mov ax, seg palleteBuffer
        mov ds, ax
        mov cx, 768
        rep outsb

        ; Desempilha registradores
        pop es ds
        popa
        ; Final do procedimento LoadPallete
        ret

LoadPallete     ENDP

;=====================================================;
; .: Procedimento ReadFile                            ;
;-----------------------------------------------------;
;    -> Copia Arquivo para Buffer                     ;
;-----------------------------------------------------;
; Parametros :
;            DS:DX Nome do Arquivo                    ;
;            ES:DI Buffer                             ;
;            CX    Tamanho                            ;
;=====================================================;
ReadFile        PROC    NEAR

        ; Empilha registradores
        pusha
        push ds es

        ; Abre o arquivo e verifica erros
        mov ax, 3D00h
        int 21h

        ; Copia o Handle de AX para BX
        mov bx, ax

        ; Copia o conteudo do arquivo para o buffer
        mov dx, es
        mov ds, dx
        mov dx, di
        mov ah, 3Fh
        int 21h

        ; Fecha o arquivo
        mov ah, 3Eh
        int 21h

        ; Desempilha registradores
        pop es ds
        popa
        ret


ReadFile        ENDP


;=====================================================;
; .: Procedimento DrawBack                            ;
;-----------------------------------------------------;
;    -> Copia o background do arquivo para o vídeo    ;
;-----------------------------------------------------;
;    Parâmetros: DS:DX      Nome do arquivo (ASCII$)  ;
;=====================================================;
DrawBack     PROC   NEAR

        ; Empilha Registradores
        pusha
        push ds es

        ; Abre o Arquivo
        mov ax, 3D00h
        int 21h

        ; Copia o Handle do Arquivo de AX para BX
        mov bx, ax

        ; DS:DX Aponta para a Memoria de Video
        mov ax, 0A000h
        mov ds, ax
        mov dx, 0

        ; Copia o Arquivo para a Memoria de Video
        mov cx, 64000
        mov ah, 3Fh
        int 21h

        ; Fecha o Arquivo
        mov ah, 3Eh
        int 21h

        ; Desempilha Registradores
        pop es ds
        popa
        ; Final do procedimento DrawBack
        ret

DrawBack     ENDP

;=====================================================;
; .: Procedimento DrawGraphics                        ;
;-----------------------------------------------------;
;    -> Desenha um gráfico na tela                    ;
;-----------------------------------------------------;
;    Parâmetros: BX      Posicao do gráfico           ;
;                CX      Largura do gráfico           ;
;                DX      Altura do gráfico            ;
;                DS:SI   Aponta para o buffer do      ;
;                        gráfico                      ;
;=====================================================;
DrawGraphics    PROC    NEAR

        ; Empilha Registradores
        pusha
        push ds es

        ; Zera DirectionFlag - faz DI incrementar apos MOVSB
        cld

        ; ES:DI Aponta para a Posicao na Memoria de Video
        mov ax, 0A000h
        mov es, ax
        mov di, bx

        ; Quantidade de Repeticoes Lineares (Largura da Figura)
        mov bx, cx

    ; Loop para a Escrita da Imagem na Memoria de Video
    ; Declarando label DGLoop
    DGLoop:

        ; Copia Linha da Imagem do Buffer para a Memoria de Video
        mov cx, bx
        rep movsb

        ; Posiciona DI para a Proxima Linha
        sub di, bx
        add di, 320

        ; Decrementa Contador de Altura
        dec dx
        jnz DGLoop

        ; Desempilha Registradores
        pop es ds
        popa
        ; Final do procedimento DrawGraphics
        ret

DrawGraphics    ENDP

end start





