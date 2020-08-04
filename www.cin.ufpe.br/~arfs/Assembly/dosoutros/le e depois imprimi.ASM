ORG 100H   ;Alocar os 100 bytes iniciais do programa
INT 16H    ;Interrompe o programa para ler do teclado, a tecla digitada eh colocada em AL
MOV AH,02H ;seta AH para 02 para que o INT 21 interprete como sendo para imprimir na tela;
MOV DL,AL  ;copia a letra para DL onde sera procurada pela INT 21H
INT 21H    ;como AH tem 02H o INT 21H pegara o que estiver em DL e jogara na tela
INT 20H    ;finaliza o programa
