.model small
.386
.stack

.data
     segmento_buffer SEGMENT byte USE16
       Buffer db 64000 dup (0)
     ENDS
     tank_buffer segment byte use16
    	buffer_tank db 1024 dup (0)
     ends
     BufferPaleta segment byte use16
    	PaletaBuffer db 768 dup (0)
     ends
     Buffer_geral segment byte use16
        BufferFundo db 64000 dup (0)
     ends

     buffer_paleta      db  768   dup(?)
     mensagem_erro db "erro$"
     fundo_dat   db 'campo.dat',0
     fundo_pal   db 'campo.pal',0
     tank_dat    db 'tank.dat', 0
     tank_pal    db 'tank.pal', 0



.code

include imagens.inc

start:
        
        MOV AH, 00H
        MOV AL, 13H
        INT 10H

        ;CarregarArquivo  tank_dat, 1024, buffer_tank
        ;CarregarArquivo  tank_pal, 768, PaletaBuffer
        ;CarregarArquivo  fundo_dat, 64000, bufferfundo


        ;call CarregarPaletaP
        ;imprimir_fig 100,100,32,32 ,buffer_tank
        desenhar_background  fundo_dat, fundo_pal
        loop11:

        desenhar_imagem  100, 100, 32, 32, fundo_pal, tank_dat, buffer_tank, 1024

        call descarregar_buffer
        jmp loop11

        mov ah, 4ch
        int 21h
end start
