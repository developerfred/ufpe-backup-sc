.model small
.stack 
.data
x dw 0090
y dw 0090
x1 dw 0
y1 dw 0
funciona db "Vc ta fudido!!!!!$"


.code

START:

      
	mov [x],0
	mov [y],0
	mov [x1],0080
	mov [y1],0080
	mov ax, 0013h  ;modo video
	int 10h
	mov ax, @data
	mov ds, ax
	mov dx, offset funciona
	mov ah, 9h
	int 21h
	
    pixel:

	
	

	mov cx, [x] 
      	mov dx, [y]
	mov ah, 0ch  ; plotando um pixel
	mov al, 2h
      	mov bh, 00h
      	int 10h	

	mov cx, [x1]  ;plotando outo pixel
 	mov dx, [y1]
	mov al, 1h
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
	
	mov ax, 4c00h  ;vê instrução de finalizar depois!!!!
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


END START

