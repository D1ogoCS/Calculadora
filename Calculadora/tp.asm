.model small ; codigo<=64k e dados<=64k com um segmento para codigo e outro para dados
.stack ;A pilha obedece a regra LIFO(Last in First out)
.data
d1 db 10  
num1 dw 0
num2 dw 0
op dw 0
result dw 0
sair dw 0
resto db 0
r dw 0


msg db "Digite uma das escolhas!",0dh,0ah

msg1 db "'-'-Subtracao",0dh,0ah
     db "'+'-Soma",0dh,0ah
     db "'*'-Multiplicacao",0dh,0ah
     db "'/'-Divisao",0dh,0ah
     db "Operacao a executar:",'$'

     
msg7 db "Digite o primeiro numero:",'$'
msg8 db "Digite o segundo numero:",'$'

msg9 db "Nao e possivel dividir por 0", 0dh,0ah
     db "Introduza outro numero:", '$'

msg10 db "Resultado : ",'$'
     
msg11 db "1 - SIM   2 - NAO   ", 0dh,0ah
      db "Deseja sair? ", '$'
      
msg12 db "Essa opcao nao e valida!",'$'

msg13 db "",0dh,0ah
      db "",0dh,0ah
      db "",0dh,0ah
      db "",0dh,0ah
      db "Obrigado",'$'

mensagem macro msg  ;Criamos uma macro para imprimir as mensagems. As macros nao presisam de palavra reservada para ser chamada e pode receber variaveis de entrada. Permitem simplificar o codigo
mov dx,offset msg
mov ax, seg msg
mov ds,ax
mov ah,9
int 21h
ENDM   
    
.code ;Indica o inicio do segmento de codigo
resto3 proc far           ;Definimos um procedimento para auxiliar no print de numeros com casa decimais
mov ah, 0
Ret
resto3 endp


mudarLinha proc far           ;Definimos um procedimento para mudar de linha pois vamos utilizar vrias vezes e assim simplificamos o codigo
mov al,13 ;Carriage Return
mov ah,14
int 10h
mov al,10 ;Linha nova
mov ah,14
int 10h
Ret
mudarLinha endp

pedirDigito proc far ;Definimos um procedimento para pedir os digitos pois vamos utilizar vrias vezes e assim simplificamos o codigo
 aa: 
 mov ah,0 ;L? caracter 
 int 16h 
 mov ah,14 ;Escreve caracter 
 int 10h 
 sub al,48 ;Descodifica caracter 
 mov ah,0 
 mul bl 
 add al,dl ;Acumula com o valor anterior 
 mov dl,al ;Guarda em dl 
 mov al,bl 
 div d1 ;Diminui a signific?ncia do algarismo 
 mov ah,0 
 mov bl,al 
 loop aa 
 mov dh,0 
 mov ax,dx ;guarda valor
 Ret
 pedirDigito endp
 
MeuCodigo:
call mudarLinha   ;Para utilizar qualquer procedimento e necessario sempre utilizar o "call" seguido do nome do procedimento

;-----------------
mov num1, 0
mov num2, 0
mov op, 0          ;Inicializacao de variaveis
mov result, 0
mov sair, 0
mov resto, 0
;-------------------

;-----------------------------------------------
mensagem msg7 ;Imprime a mesnagem msg7

mov bx,10 
mov cx,2 ;Como precisamos de dois digitos temos de criar um ciclo para pedir o digito duas vezes entao fazemos cx a 2 e o bx a 10
mov dx,0 
call pedirDigito ;Pede o primeiro numero
mov num1, ax  ;guarda o primiro numero pedido ao utilizador na variavel num1
;-------------------------------------------------

call mudarLinha

;-----------------------------------------------
pedeOperador:
mensagem msg1 ;Imprime a mesnagem msg1 

mov bx,1 
mov cx,1      ;Como so precisamos um digito fazemos cx a 1 e o bx a 1
mov dx,0 
call pedirDigito ;Pede o operador
mov op,ax ;guarda o operador em op
;------------------------------------------------

call mudarLinha

;-----------------------
descodifica:
mov ax,op
add al,48               ;Descodifica o caracter do operador para codigo ascii
mov op ,ax
;-----------------------

;---------------------------

;Depois de descodificar o operador para codigo ascii, temos de comparar o operador introduzido com o +,-,*,/
;Se o utilizador introduziu um operador valido ele salta para pedir o segundo numero

cmp op, 42
je pedeNumero2

cmp op, 45
je pedeNumero2

cmp op, 43          
je pedeNumero2         

cmp op, 47
je pedeNumero2

jmp pedeOperador    ;Se o caracter que o utilizador introduziu nao pertence a uma opcao ele salta para pedir novamente o operador
;------------------------

;--------------------------------------------
pedeNumero2:
mensagem msg8 ;Imprime a mesnagem msg8

mov bx,10 
mov cx,2
mov dx,0 
call pedirDigito ;Pede o segundo numero
mov num2, ax

call mudarLinha
;----------------------------------------------


;--------------------------
Calculo:
cmp op, 45 ;subtracao               Se o utilizador introduziu um caracter que indica um operador , necessario compara-lo para se saber para  qual operacao se deve fazer o salto
je subtrac  ;salta para a subtracao

cmp op, 43 ;soma
je soma ;salta para a soma
                                        ;Faz as comparacoes para ir para onde o utilizador pediu
cmp op, 42 ;multiplicacoa
je multi    ;salta para a multiplicacao

cmp op, 47 ;divisao
je divi ;salta para a divisao

;---------------------------------


;--------------
saltoMeio2:     
jmp MeuCodigo       ;Serve para saltar para o inicio do codigo
;---------------



;-------------------------------------------------------------------
subtrac:
mov bx, num2    ;Em todas as operacoes movemos o num2 para bx e o num1 para ax
mov ax, num1
sub ax, bx      ;subtrai e guarda o resultado em ax
mov result, ax      ;Depois movemos o valor que esta em ax para a variavel results
cmp ax, 0 ; compara para saber se o numero e positivo ou negativo
jge results1    ;? necessario fazer o salto para imprimir o resultado da operacao
jmp num_neg

num_neg:; codigo para imprimir numeros negativos
neg ax ;negar ax para obter numero positivo para impressao
mov result, ax

 
mov ah, 2           ; imprime o sinal de menos
mov dl, '-'
int 21h

mov ax, result
mov bx,100
mov cx,3 ;Repete o ciclo 3 vezes 
 
 Ciclo1: ; ciclo para imprimir numeros de ate 3 digitos
 div bl 
 push ax 
 add al,48 
 mov ah,14 ;Escreve caracter 
 int 10h 
 mov ax,bx 
 div d1 
 mov bl,al 
 pop ax 
 mov al,ah 
 mov ah,0 
 loop Ciclo1 
jmp desejaSair


;----------------------------------------------------------------

soma:
mov bx, num2
mov ax, num1
add ax, bx          ;soma e guarda o resultado em ax
mov result, ax
jmp results     ;? necessario fazer o salto para imprimir o resultado da operacao

multi:
mov bx, num2
mov ax, num1
mul bx              ;multiplica e guarda o resultado em ax
mov result, ax
jmp results     ;? necessario fazer o salto para imprimir o resultado da operacao

;-------------------------------
results1:
jmp results
;----------------------------
 
divi:
WHILE:
cmp num2,00             ;Compara se o numero do divisor que o utilizador introduziu e zero
jne ENDWHILE             ; Caso o valor do divisor for zero , necessario pedi-lo novamento, se for diferente de zero ele salta para fazer a divisao

mensagem msg9 ;Imprime a mesnagem msg9
                         
mov bx,10 
mov cx,2
mov dx,0 
call pedirDigito ;Pede o segundo numero
mov num2, ax

call mudarLinha

jmp WHILE
ENDWHILE:
    mov bx, num2
    push bx
    mov ax, num1
    div bl          ;faz divisao
    mov result, ax
    cmp ah, 0  ;compara ah a 0 para saber se o numero tem casas decimais
    jne decimal ; se for decimal salta para label decimal
jmp results

;--------------------------------------------------------------------
decimal:
mov resto, 1 ; se o numero for decimal, resto serve de flag sendo colocado a 1
jmp results
;----------------

saltoMeio:      ;salto intermedio devido ao dalto condicional ter limite de alcance
jmp saltoMeio2
;------------------


;----------------------------------------------------------------------
results:

mensagem msg10; Imprime a mesnagem msg10 

 mov ax, result ;Movemos o resultado das operacoes novamente para ax
 mov r, ax
 
 if:
 cmp resto, 1 ; verifica se o numero tem casas decimais
 je else
 jmp endif
 else:
 call resto3 ; se tiver casas decimais salta para label resto 3 para colocar ah a 0, permitindo assim a impressao do numero inteiro
 endif:

 mov bx,100
 mov cx,3 ;Repete o ciclo 3 vezes 
 
 Ciclo: ;ciclo para imprimir numeros ate 3 digitos
 div bl 
 push ax 
 add al,48 
 mov ah,14 ;Escreve caracter 
 int 10h 
 mov ax,bx 
 div d1 
 mov bl,al 
 pop ax 
 mov al,ah 
 mov ah,0 
 loop Ciclo 
 
 cmp resto, 1 ; verifica se o numero tem casas decimais
 je resto2 ; se tiver casas decimais salta para label propria para imprimir virgulas e casas decimais
 
 jmp desejaSair ;Depois de imprimir o resultado , ? necessario perguntado ao utilizador se deseja sair do programa
;--------------------------------------------------------------
 resto2: ; label para imprimir virgulas e casas decimais
pop bx
mov ax, r
push ax
mov al,',' ;Escreve caracter ","
mov ah,14
int 10h
pop ax
mov al,ah ;Escreve decimal
mov ah,0
mul d1
div bl

add al,48
mov ah,14
int 10h
jmp desejaSair

;---------------------------------------------------
erro:
call mudarLinha
mensagem msg12 ;Imprime a mesnagem msg12
;-------------------------------------------------


;--------------------------------------------
desejaSair:
call mudarLinha
call mudarLinha

mensagem msg11; Imprime a mesnagem msg11

mov bx,1 
mov cx,1 
mov dx,0 
call pedirDigito ;Pede ao utilizador se quer sair ou nao
mov sair, ax

cmp sair,1      ;Como so ha duas opcoes ? necessario verificar a entrada do input. Se o utilizador introduzui 1 ele sai do programa
je fim

cmp sair, 2         ;Se o utilizador introduzui 2 ele salta para o inicio do programa
jne erro            ;Se nao escolheu nenhuma das opcaoes ? necessario voltar a perguntar e entao ele salta para apresentar a mensagem de erro
jmp saltoMeio       ;Salta para o inicio do programa
;---------------------------------------


fim:
call mudarLinha
mensagem msg13; Imprime a mesnagem msg13

mov ah,4ch ;Termina e limpa a memoria 
int 21h 
end MeuCodigo 
.End 
