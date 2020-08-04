.model small
.386
.stack
.data
include dado.inc
modo_video   db ?

t1_posicaox  dw ?
t1_posicaoy  dw ?
t2_posicaox  dw ?
t2_posicaoy  dw ?

t1_antiga_posicaox  dw ?
t1_antiga_posicaoy  dw ?
t2_antiga_posicaox  dw ?
t2_antiga_posicaoy  dw ?


palleteBuffer         db  768   dup(?)
Seed                 dw 0

      msg1                 db "ERRO NO ARQUIVO$"
      msg2                 db "ERRO NO ARQUIVO$"
      msg3                 db "ERRO NO ARQUIVO$"
      msg4                 db "ERRO NO ARQUIVO$"
      scoreFile            db 'score.dat', 0

.code  

main:

; Armazenando informação de Vídeo
; Atual e mudando para o modo 13h

    mov ah, 0Fh        ; função 0Fh - obt‚m modo Atual
    int 10h            ; serviço de vídeo da BIOS
    mov modo_video,al  ; salvando modo Atual

    mov	ax, @data  ;variaveis para a memoria
    mov	ds, ax

    mov ax,13h          ; modo 13h
    int 10h            ; serviço da BIOS
    
    
; Escrevendo Pixels Iniciais...

    mov t1_posicaox, 100  ; posicao x inicial
    mov t1_posicaoy, 100  ; posicao y inicial
    mov t2_posicaox, 200  ; posicao x inicial
    mov t2_posicaoy, 100  ; posicao y inicial

    call Menu
    ;call desenho          ; procedimento para desenho
     nop



; While Principal
; do Programa

loop_principal:

    call teclado
    call desenho

    jmp loop_principal


desenho PROC

    mov ah, 0Ch          ; função de escrita de pixels
    mov al, 0            ; cor preta para limpar pixel anterior

    mov cx, t1_antiga_posicaox      ; Recuperando Antigas coordenadas
    mov dx, t1_antiga_posicaoy      ; e efetuando a limpeza
    int 10h
    mov cx, t2_antiga_posicaox
    mov dx, t2_antiga_posicaoy
    int 10h

    mov al, 4            ; cor vermelha
    mov cx,t1_posicaox   ; posicao x
    mov dx,t1_posicaoy   ; posicao y
    int 10h              ; serviço da BIOS
    mov al, 2            ; cor verde
    mov cx,t2_posicaox   ; posicao x
    mov dx,t2_posicaoy   ; posicao y
    int 10h              ; serviço da BIOS

    ret
desenho ENDP

teclado PROC

    xor ax,ax          ; função 00h - obter uma tecla
    int 16h            ; serviço da BIOS

    push bx

    mov bx, t1_posicaox          ; Armazenando antigas coordenadas
    mov t1_antiga_posicaox, bx   ; para futura Limpeza da tela
    mov bx, t1_posicaoy
    mov t1_antiga_posicaoy, bx
    mov bx, t2_posicaox
    mov t2_antiga_posicaox, bx
    mov bx, t2_posicaoy
    mov t2_antiga_posicaoy, bx

    pop bx

    cmp al,'a'         ; comparações com a tecla
    je t1_esquerda     ; pressionada
    cmp al,'d'
    je t1_direita
    cmp al,'w'
    je t1_cima
    cmp al,'s'
    je t1_baixo
    cmp al,'j'
    je t2_esquerda
    cmp al,'l'
    je t2_direita
    cmp al,'i'
    je t2_cima
    cmp al,'k'
    je t2_baixo
    cmp al,'q'
    je sair
    jmp fim_proc

  t1_esquerda:
    sub t1_posicaox, 2
    jmp fim_proc

  t1_direita:
    add t1_posicaox, 2
    jmp fim_proc

  t1_cima:
    sub t1_posicaoy, 2
    jmp fim_proc

  t1_baixo:
    add t1_posicaoy, 2
    jmp fim_proc

  t2_esquerda:
    sub t2_posicaox, 2
    jmp fim_proc

  t2_direita:
    add t2_posicaox, 2
    jmp fim_proc

  t2_cima:
    sub t2_posicaoy, 2
    jmp fim_proc

  t2_baixo:
    add t2_posicaoy, 2
    jmp fim_proc

  sair:
    mov al, modo_video   ; voltando ao modo anterior
    xor ah,ah            ; zerar ah - programar modo
    int 10h              ; serviço da BIOS

    mov ax, 4C00h        ; sair para o DOS
    int 21h              ; serviço do DOS

  fim_proc:

    ret
teclado ENDP

Menu proc

        inicio:
         mov dx, offset menuini_pal
         call CarregaPaleta
         mov dx, offset menuini
         call DesenhaTela
         mov cx, 00h

       ; CX = 00h - menu Iniciar
       ; CX = 01h - menu Creditos
       ; CX = 02h - menu Pontuacao
       ; CX = 03h - menu Ajuda
       ; CX = 04h - menu Sair
       ; 1C0D = tecla enter


       pimpa:
        xor ax,ax
        int 16h

        cmp ax, 5000h
        je baixo
        cmp ax, 4800h
        je  cima
        cmp ax, 1C0Dh
        je tecenter
        jmp pimpa

baixo:
        cmp  cx,00h
        je vaipaCred
        cmp cx, 01h
        je vaipaPont1
        cmp cx, 02h
        je vaipaAjuda
        cmp cx, 03h
        je vaipaSair
        cmp cx, 04h
        je vaipaIni
        jmp pimpa
vaipapimpa:
jmp pimpa
cima:
        cmp  cx,00h
        je vaipaSair
        cmp cx, 01h
        je vaipaIni
        cmp cx, 02h
        je vaipaCred
        cmp cx, 03h
        je vaipaPont1
        cmp cx, 04h
        je vaipaAjuda
        jmp vaipapimpa
vaipaPont1:
jmp vaipaPont
vaipapimpa1:
jmp vaipapimpa
tecenter:
        cmp  cx,00h
        je entrajogo
        cmp cx, 01h
        je entracreditos
        cmp cx, 02h
        je entrapont
        cmp cx, 03h
        je entraajuda
        cmp cx, 04h
        je saicanso
        jmp pimpa


vaipaPont:
call telaPont
jmp vaipapimpa1

vaipapimpa2:
jmp vaipapimpa1

vaipaSair:
call telaSair
jmp vaipapimpa2

vaipaIni:
call telaIni
jmp vaipapimpa2

vaipaCred:
call telaCred
jmp vaipapimpa2


vaipaAjuda:
call telaAjuda
jmp vaipapimpa2

quit:
call quitGame

entrajogo:

entracreditos:

entrapont:

entraajuda:

saicanso:
call entrasai

Menu endp

; xxxxxxxxxxxx  PROCEDIMENTOS PARA CARREGAR OS MENUS    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
telaIni proc
         mov dx, offset menuini_pal
         call CarregaPaleta
         mov dx, offset menuini
         call DesenhaTela
         mov cx,00h
         ret

telaIni endp

telaPont proc  near
         
         mov dx, offset menupont_pal
         call CarregaPaleta
         mov dx, offset menupont
         call DesenhaTela
         mov cx,02h
         ret
         
telaPont endp

telaCred proc
         mov dx, offset menucred_pal
         call CarregaPaleta
         mov dx, offset menucred
         call DesenhaTela
         mov cx,01h
         ret
telaCred endp

telaAjuda proc
         mov dx, offset menuajuda_pal
         call CarregaPaleta
         mov dx, offset menuajuda
         call DesenhaTela
         mov cx,03h
         ret

telaAjuda endp

telaSair proc
         mov dx, offset menusair_pal
         call CarregaPaleta
         mov dx, offset menusair
         call DesenhaTela
         mov cx,04h
         ret
telaSair endp

; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX FIM DO PROCEDIMENTO DOS MENUS XXXXXXXXXXXXXXXXXXXXXXXXXXX


entrasai proc


    ini:
         mov dx, offset askfim_pal
         call CarregaPaleta
         mov dx, offset askfim
         call DesenhaTela
         mov cx,00h

         xor ax,ax
         int 16h

         cmp al, 's'
         je quit
         cmp al, 'S'
         je quit
         cmp al,'n'
         je ini
         cmp al,'N'
         je ini

         ret

entrasai endp

quitGame proc

    mov ax, 03h
                        int 10h
                        mov ah, 4ch    ; volta pro DOS
                        int 21h
                        popa
quitGame endp

imprimir_fig macro posX, posY, comp, larg, figbuffer1;,aumenta; passar como parametro o comprimento e largura da figura
        Local linhaloop, colunaloop, naoimprime
        push ax bx cx dx
        push ds es





        ;mov ds, seg figbuffer
        mov si, offset figbuffer1
        ;mov si, aumenta

        mov bx, posX
        mov dx, posY
        mov di, bx
        mov bx, dx
        shl dx, 8                ;Y*256
        shl bx, 6                ;y*64
        add dx, bx               ;y*320
        add di, dx               ;y*320 + X

        mov ax, seg Buffer
        mov es, ax
        mov ax, seg figbuffer1
        mov ds, ax



        mov dx, comp             ;  tinha comp
        linhaloop:
            mov cx, larg         ;tinha larg
            ;rep movsb
             ;add si, saida
            colunaloop:                    ;esse loop faz o q rep movsb faz
                mov ah, DS:[SI]
                cmp ah, 35                ;cor que não vai ser impressa

                je naoimprime

                            ;caso seja transparente, nao imprime
                mov ES:[DI], ah            ;local que imprime
                naoimprime:
               inc DI
                inc SI
                loop colunaloop            ;loop que ja decrementa cx

               ;add si, entrada			;y = largura oficial da figura - diferença da posição inicial pela posição atual (apenas se a mesma for menor q a lagura oficial)

           add di, 320                    ; para que ele possa imprimir a figura na ordem certa
           sub di, larg                   ;tinha larg
           dec dx
       cmp dx, 0                          ;vai decrementando dx ate dx ser 0
       jne linhaloop
       ;rep movsb; substituir por um loop para adicionar o di 320 - comprimento a cada linha

        pop es ds
	pop dx cx bx ax
endm


;================================================================================
;x Proc DesenhaTela
;x
;x Descrição: Copia uma imagem de um Arquivo para o Video
;x
;x Parametros
;x   DS:DX   Nome do Arquivo (ASCIIZ)
;================================================================================
DesenhaTela PROC NEAR

;Empilha Registradores
push ax
push bx
push cx
push dx
push ds
push es

;Abre o Arquivo (3D) como somente leitura (00)
mov ah, 3Dh
;Seta somente leitura
mov al, 00h
int 21h

;Copia o Handle do Arquivo de AX para BX que sera usado na proxima int 21h
mov bx, ax

;DS:DX Aponta para a Memoria de Video
mov ax, 0A000h
mov ds, ax
mov dx, 0

;Lê a partir do arquivo aberto e o copia para a Memoria de Video
;cx - Numero de iterações - 64000 (320x200)
mov cx, 64000
mov ah, 3Fh
int 21h

;Fecha o Arquivo
mov ah, 3Eh
int 21h

;Desempilha Registradores
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;Fim do procedimento DesenhaTela
DesenhaTela     ENDP

;=================================================================================
;Macro CarregarArquivo
;=================================================================================
CarregarArquivo macro path, bytes, buffer

	push ds ax bx cx dx

	mov ax, seg path
	mov ds, ax                           ; posiciona ds no segmento do path
	mov dx, offset path
	mov ax, 3d00h                        ; funcao de abrir arquivo no modo somente leitura
	int 21h

	mov bx, ax                           ; passa o handle para bx
 	mov ax, seg buffer
	mov ds, ax                           ; posiciona ds no segmento de buffer
	mov dx, offset buffer
	mov cx, bytes                        ; quantos bytes serao lidos
	mov ah, 3fh                          ; funcao de ler o arquivo
	int 21h

	mov ah, 3eh
	int 21h

        pop dx cx bx ax ds

endm 



;================================================================================
;x PROC CarregaPaleta                                                           x
;x                                                                              x
;x Descrição: Procedimento que carrega uma paleta de cores                      x
;x            na sua variável correspondente.                                   x
;x                                                                              x
;x Parametros:                                                                  x
;x DS:DX - Nome do arquivo da paleta                                            x
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CarregaPaleta PROC NEAR

;Empilha os registradores
push ax
push bx
push cx
push dx
push ds
push es
push di
push si

;Faz com que ES aponte para o segmento de dados
mov ax,@data
mov es,ax   ;trocar depois para ds, pra ver se funciona

;Passa o endereço do arquivo da paleta para DI
mov di, offset palleteBuffer       ; trocar para dx
mov cx, 768
;Lê o arquivo
call ReadFile

;Ativa escrita da paleta (Porta 3C8H)

;Avisa a interface de video que a paleta vai ser modificada
mov dx,3C8h
mov al,0
out dx,al     ; por que avisar com zero?

;Incrementa o valor de dx para 3C9H, para modificar a paleta
inc dx

;Manda 768 bytes do buffer para a paleta
;outsb envia o conteúdo de si para o endereço da porta contido em dx
mov si, offset palleteBuffer
mov ax, seg palleteBuffer
mov ds,ax
mov cx,768
rep outsb


; Desempilha Registradores
pop si
pop di
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret

;Fim do procedimento Carregar Paleta
CarregaPaleta ENDP

;================================================================================
;  Procedimento ReadFile
;  Copia Arquivo para Buffer
;  Parametros
;    DS:DX   Nome do Arquivo
;    ES:DI   Buffer
;    CX      Tamanho
;================================================================================

ReadFile PROC NEAR
                                           ;Empilha registradores
                   pusha
                   push ds
                   push es
                                           ; Abre o arquivo e verifica erros
                   mov ax, 3D00h
                   int 21h
                   jc  ErrorOpenFile
                                           ;Copia o Handle de AX para BX
                   mov bx, ax
                                           ;Copia o conteudo do arquivo para o buffer
                   mov dx, es
                   mov ds, dx
                   mov dx, di
                   mov ah, 3Fh
                   int 21h
                   jc  ErrorOpenFile
                                           ;Fecha o arquivo
                   mov ah, 3Eh
                   int 21h
                  jc  ErrorOpenFile

                                           ;Finaliza o procedimento
    RFExit:
                                           ;Desempilha registradores
                  pop es
                   pop ds
                   popa
                   ret
                                           ;Tratamento de erros
   ErrorOpenFile1:

                   mov dx, offset msg4
                   mov ax, 03h             ; mudar para mostrar figura
                   int 10h
                                           ;Exibe a string (DS:DX) na tela
                   mov ah, 09h
                   int 21h
                                           ;Retorna o controle ao SO
                   mov ax, 4C01h
                   int 21h

    ErrorOpenFile:
                                           ;Verifica se foi FileNotFoundError
                   cmp ax, 02h
                   je  ErrorFileNotFound
                                           ;DS:DX aponta para mensagem de erro
                   mov dx, offset msg1
                   jmp ErrorExit
                                           ;Trata o erro de FileNotFoundError
    ErrorFileNotFound:
                                           ;Verifica se foi o arquivo de Recordes
                   cmp dx, offset scoreFile
                   je  CreateScoreFile
                                           ;DS:DX aponta para mensagem de erro
                   mov dx, offset msg2
                                           ;Finaliza o tratamento de erros
    ErrorExit:
                                           ;Retorna ao modo texto
                   mov ax, 03h
                   int 10h
                                           ;Exibe a string (DS:DX) na tela
                   mov ah, 09h
                   int 21h
                                           ;Retorna o controle ao SO
                   mov ax, 4C01h
                   int 21h
                                           ;Cria o arquivo de Recordes
    CreateScoreFile:
                                           ;Cria o arquivo
                   mov cx, 00h
                   mov ah, 3Ch
                   int 21h
                                           ;Fecha o arquivo
                   mov bx, ax
                   mov ah, 3Eh
                   int 21h
                                           ;Finaliza o procedimento
                   jmp RFExit


ReadFile        ENDP
;================================================================================
;  FIM do Procedimento ReadFile
;================================================================================

CarregarPaletaP proc near
	push ds si ax cx dx

    xor al, al
	mov dx, 3c8h ; aponta dx para a porta
	out dx, al ; avisa que a paleta vai mudar
	inc dx

    mov ax, seg PaletaBuffer
	mov ds, ax
	mov si, offset PaletaBuffer ; aponta para offset de PaletaBuffer
    mov cx, 768 ; quanto bytes tem a paleta
	rep outsb ; e transfere a paleta para a memoria de video

	pop dx cx ax si ds

	ret
CarregarPaletaP endp
; ------------------------------------------------PArte do Jogo 2 ----------------------------------------------------

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



end main
