.model small
.stack
.data
x dw 0090
y dw 0090
x1 dw 0
y1 dw 0
x2 dw ?
y2 dw ?
tiro dw ?

.code

START:

      
	mov [x],0050
	mov [y],0050
	mov [x1],0080
	mov [y1],0080

    pixel:

	mov ax, 0013h  ;modo video
	int 10h


	mov cx, [x] 
      	mov dx, [y]
	mov ah, 0ch  ; plotando um pixel
	mov al, 2h
      	mov bh, 00h
      	int 10h	

	mov cx, [x1]  ;plotando outo pixel
 	mov dx, [y1]
	int 10h
	

	mov ah, 00h    ;lendo uma tecla 
	int 16h

	cmp ax, 4D00h
    	je direita
    
    	cmp ax, 4B00h
    	je esquerda
    
    	cmp ax, 4800h
    	je baixo
    
    	cmp ax, 5000h
    	je cima

	cmp ax, 2064h
    	je direita1
    
    	cmp ax, 1e61h
    	je esquerda1
    
    	cmp ax, 1f73h
    	je cima1
    
    	cmp ax, 1177h
    	je baixo1

	cmp ax,3920h
	je bala

	mov ax, 4c00h
	int 21h     ;em caso de nenhuma dessas teclas finalizar

    
    direita:

	add [x], 1
	mov cx,[x]
	jmp pixel

    esquerda:
	
	sub [x], 1
	mov cx, [x]
	jmp pixel

    cima:
 	
        add [y],1
	mov dx,[y]
	jmp pixel

    baixo:
       
        sub [y],1
	mov dx,[y]
	jmp pixel

    direita1:

	add [x1],1
	mov cx,[x1]
	jmp pixel

    esquerda1:
	
	sub [x1], 1
	mov cx, [x1]
	jmp pixel

    cima1:
 	
        add [y1],1
	mov dx,[y1]
	jmp pixel

    baixo1:
       
        sub [y1],1
	mov dx,[y1]
	jmp pixel

    bala:

	mov ax, 0013h  ;modo video
	int 10h


	mov cx, [x] 
      	mov dx, [y]
	mov ah, 0ch  ; plotando um pixel
	mov al, 2h
      	mov bh, 00h
      	int 10h	

	mov cx, [x1]  ;plotando outo pixel
 	mov dx, [y1]
	int 10h

        

        push ax
        mov ax,[x1]
        mov [x2], ax
        mov [tiro], ax
        mov ax, [y1]
        mov[y2], ax
        pop ax
        add [tiro], 50

     tir:

        add [x2],2
        mov cx, [x2]
        mov dx, [y2]
        int 10h
        push ax
        mov ax, [x2]
        cmp ax, [tiro]
        pop ax
        jb tir
        jmp pixel





END START

