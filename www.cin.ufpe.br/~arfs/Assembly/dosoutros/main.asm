.model small
.386
.stack

.data

; Incluindo Dados
include dados.inc



.code

; Incluindo Código de Imagens
include imagens.inc

; Incluindo Código de Teclado
include teclado.inc

; Incluindo Código dos Tanques
include tanques.inc


;================================================================================
;x Procedimento Inicialização                                                   x
;x                                                                              x
;x Procedimento que determina os valores iniciais                               x
;x das variaveis principais do Programa                                         x
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
inicializacao PROC NEAR

    ; Modo de Vídeo 13h
    mov ax, 13h
    int 10h

    ; Determinando Coordenadas & Direções Iniciais
    mov t1_posicaox, 100
    mov t1_posicaoy, 100
    mov t2_posicaox, 200
    mov t2_posicaoy, 100

    mov t1_posicaox_anterior, 100
    mov t1_posicaoy_anterior, 100
    mov t2_posicaox_anterior, 200
    mov t2_posicaoy_anterior, 100

    mov t1_direcao, 0
    mov t2_direcao, 0

    ; Limites da Tela
    mov limite_superior, 0
    mov limite_esquerda, 0
    mov limite_direita,  318
    mov limite_inferior, 198

    ; Deslocamento
    mov deslocamento, 2

    ; Configurando Interrupção
    ; do Teclado
    call configurar_int15

    ret

inicializacao ENDP


;================================================================================
;x Procedimento Finalização                                                     x
;x                                                                              x
;x Procedimento que encerra o Programa                                          x
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
finalizacao PROC NEAR

   ; Restaurando
   ; Interrupção 15h
   call recuperar_int15

   ; Voltando ao modo
   ; Gráfico Normal
   mov ah, 00h
   mov al, 02h
   int 10h

   ; Pequena Mensagem
   mov ah, 09h
   mov dx, OFFSET mensagem_final
   int 21h

   xor ah,ah
   int 16h

   ; Sair para o DOS
   mov ah, 4Ch
   mov al, 00h
   int 21h

   ret

finalizacao ENDP



atraso PROC NEAR

    pusha
    mov ah, 0
    int 01Ah
    add dl, 25h
    mov bl, dl

  wait1:

    mov ah, 0
    int 01Ah
    cmp dl, bl
    jnz wait1

    popa
    ret

atraso ENDP


evento_desenho PROC

    push dx
    mov dx, OFFSET paleta_background
    call carregar_paleta
    mov dx, OFFSET imagem_background
    call desenhar_tela
    pop dx

    ;desenhar_grafico t1_posicaox, t1_posicaoy, 32, 32, paleta_tanque, imagem_tanque, buffer_tanque, 1024
    ;desenhar_grafico t2_posicaox, t2_posicaoy, 32, 32, paleta_tanque, imagem_tanque, buffer_tanque, 1024

    ret

evento_desenho ENDP



main:

  call inicializacao

  ; While Principal
  ; do Programa

  loop_principal:

    call evento_desenho
    call movimento_tanques

    ; Condição de Saída
    cmp botao_esc, 1
    jne loop_principal

    call finalizacao
    jmp loop_principal

end main
