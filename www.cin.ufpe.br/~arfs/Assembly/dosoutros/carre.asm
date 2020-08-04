.model small
.stack
.data
caminho db "img/jogo.dat"
buffer db 500*dup(?)
.code

mov ah,00h
mov al,13h
int 10h
mov ah,3dh
mov al,00h
mov dx,offset caminho
mov ds, @data
int 21h
mov bx,ax
mov ah,3fh
;mov al,00h
mov cx,500
mov ds,@data
mov dx, offset buffer
int 21h
mov ax,a000h
mov es, ax
mov ah,00h
rotulo:
mov bx,[buffer]
mov [ah],bx
inc 
