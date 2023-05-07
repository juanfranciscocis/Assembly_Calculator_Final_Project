 




; OPERACIONES

; SUMA, RESTA, MULTIPLICACION, DIVISION, LOGARITMO BASE 10, SENO, COSENO, TANGENTE, INVERSAS, POTENCIA 
; RANDALL LOG 10, MODULO
; EDWIN   POTENCIA, RAIZ     
; DANIELA INVERSAS          
; JUAN FRANCISCO SENO,COSENO, TANGENTE
 
 

.data
    mostrarMenu db '===============.MENU.===============',13,10
                db '1. Suma',13,10
                db '2. Resta',13,10
                db '3. Division',13,10
                db '4. Multiplicacion',13,10
                db '5. Logaritmo' , 13,10
                db '6. Modulo' , 13,10
                db '7. Potencia' , 13,10
                db '8. Raiz' , 13,10
                db '9. Seno' , 13,10
                db '10. Coseno' , 13,10
                db '11. Tangente' , 13,10
                db '12. Arcsin' , 13,10
                db '13. Arccos' , 13,10
                db '14. Arctan' , 13,10
                db '15. Salir',13,10,13,10
				db 'Seleccione una Opcion -->$',13,10  
				
	new_line db 10,13, " $"
	
	msg_op_suma db 10,13, 'SUMA','$'
	msg_op_resta db 10,13, 'RESTA','$'
	msg_op_multi db 10,13, 'MULTIPLICACION','$'
	msg_op_div db 10,13, 'DIVISION','$'
	msg_op_log db 10,13, 'LOGARITMO','$'      
	msg_op_modulo db 10,13, 'MODULO','$'
	msg_op_pot db 10,13, 'POTENCIA','$'
	msg_op_raiz db 10,13, 'RAIZ','$'
	msg_op_sen db 10,13, 'SENO','$'
	msg_op_cos db 10,13, 'COSENO','$'
	msg_op_tan db 10,13, 'TANGENTE','$'
	msg_op_arcsin db 10,13, 'ARCSIN','$'
	msg_op_arccos db 10,13, 'ARCCOS','$'
	msg_op_arctan db 10,13, 'ARCTAN','$'
	
	
	
    num1 db ?
	num2 db ?
    msg_num db 10,13,'Proporciona un numero: ', 	'$'
    msg_suma db 10,13,'Suma: = ',				'$'
	msg_resta db 10,13,'Resta: = ',				'$'
    msg_div db 10,13,'Division: = ',			'$'
    msg_multi db 10,13,'Multiplicacion: = ',	'$'
    msg_log db 10,13, 'LOGARITMO: = ','$'      
	msg_modulo db 10,13, 'MODULO: = ','$'
	msg_pot db 10,13, 'POTENCIA: = ','$'
	msg_raiz db 10,13, 'RAIZ: = ','$'
	msg_sen db 10,13, 'SENO: = ','$'
	msg_cos db 10,13, 'COSENO: = ','$'
	msg_tan db 10,13, 'TANGENTE: = ','$'
	msg_arcsin db 10,13, 'ARCSIN: = ','$'
	msg_arccos db 10,13, 'ARCCOS:= ','$'
	msg_arctan db 10,13, 'ARCTAN = ','$'
    decenas db ?
    unidades db ?
	decenasPorTen db ?
	op_menu db ?
	seno_res db ?
; MACROS

; Este macro imprime un mensaje
imprimir macro dato
    mov ah,09h
    lea dx,dato ; Cargar dato
	int 21h ; Interrupci�n servicio de video
endm

pedirNum MACRO dato
	
	imprimir msg_num
    ; Lee el primer número
    mov ah, 01h   ; Función de entrada desde el teclado
    int 21h       ; Llamada al servicio de interrupción de BIOS
    sub al, 30h   ; Convierte el caracter ASCII en un número
    mov decenas, al    ; Guarda el primer dígito en el registro BL

    ; Lee el segundo número
    mov ah, 01h   ; Función de entrada desde el teclado
    int 21h       ; Llamada al servicio de interrupción de BIOS
    sub al, 30h   ; Convierte el caracter ASCII en un número
    mov unidades, al    ; Guarda el segundo dígito en el registro BH

    ; Une los dos dígitos en un solo número
	mov al, decenas    ; Mueve el primer dígito al registro AL
	mov decenasPorTen, 10    ; Mueve el valor 10 al registro BL
	mul decenasPorTen       
	add al, unidades    ; Suma unidades a AL
	mov dato, al  ; Guarda el número en la variable data

endm









operacionSuma macro
		imprimir msg_suma
        mov al,num1
        add al,num2
        aam
        mov decenas,ah
        mov unidades,al
        add decenas,30h ;ajuste manual
		add unidades,30h
		; imprimir valores
        mov ah,02h
        mov dl,decenas
        int 21h
        mov ah,02h
        mov dl,unidades
        int 21h
endm
operacionResta macro
		imprimir msg_resta
        xor ax,ax
        mov al, num1
        mov bl,num2
        div bl
        aam
        
        mov decenas,ah
        mov unidades,al
        
        add decenas,30h
        add unidades,30h
        ; imprimir valores
        mov ah,02h
        mov dl,decenas
        int 21h
        
        mov ah,02h
        mov dl,unidades
        int 21h
endm
operacionMultiplicacion macro
		imprimir msg_multi
        mov al,num1
        mov bl,num2
        mul bl
        aam
        
        mov decenas,ah
        mov unidades,al
        
        add decenas,30h ;ajuste manual
        add unidades,30h
        ; imprimir valores
        mov ah,02h
        mov dl,decenas
        int 21h
        
        mov ah,02h
        mov dl,unidades                                                                         
        int 21h
endm
;COMMENT
;operacionDivision macro
	;	imprimir msg_div
  ;      xor ax,ax
   ;     mov al, num1
    ;    mov bl,num2
     ;   div bl
      ;  aam
       ; 
        ;mov decenas,ah
   ;     mov unidades,al
    ;    
     ;   add decenas,30h
      ;  add unidades,30h
        ; imprimir valores
       ; mov ah,02h
        ;mov dl,decenas
;        int 21h
 ;       
  ;      mov ah,02h
   ;     mov dl,unidades
    ;    int 21h
;endm

;factorial
operacionLogaritmo macro ;Randall 
        xor ax,ax
        imprimir new_line
        mov bl, num1   ; move num1 to CL
        mov al, 1      ; set AL to 1
        loopstart:
        mul bl      ; Multiply AL by CL
        dec bl      ; Decrement CL
        cmp bl,0
        
        jne loopstart   ; Jump to loopstart if CL is not zero
         
        aam 
        mov decenas,ah
        mov unidades,al  
        add unidades,30h
        mov al, ah
        cmp al,0
        jbe end
        
        add decenas,30h ;ajuste manual
       
        ; imprimir valores
        mov ah,02h
        mov dl,decenas
        int 21h
        
        
        end:
        
        mov ah,02h
        mov dl,unidades                                                                         
        int 21h
        
        
endm

        
        
;porcentaje        
operacionDivision macro
		imprimir msg_div
        ;cuanto es porcentaje de num1 en num2
        mov al, num1

        
        mov bl, 100
        mul bl


        mov bl, num2
        div bl
        
        
        aam
        
        mov decenas,ah
        mov unidades,al
        
        add decenas,30h
        add unidades,30h
        ; imprimir valores
        mov ah,02h
        mov dl,decenas
        int 21h
        
        mov ah,02h
        mov dl,unidades
        int 21h
    
        
        
        
       
endm

operacionModulo macro ;Randall
		imprimir msg_modulo
		xor ax,ax
        mov al, num1
        mov bl,num2
        div bl
        mov al,ah
        aam
        
        mov decenas,ah
        mov unidades,al
        
        add decenas,30h
        add unidades,30h
        ; imprimir valores
        mov ah,02h
        mov dl,decenas
        int 21h
        
        mov ah,02h
        mov dl,unidades
        int 21h
endm

operacionPotencia macro ; Edwin
		imprimir msg_pot
endm

operacionRaiz macro ;Edwin
		imprimir msg_raiz
endm

operacionSeno macro ;Juan
		imprimir msg_sen
		; given num1 in degrees calculate sin(num1)
		; using the Taylor series expansion
		mov al, num1
		mov bl, 180
		div bl
		mov bl, al
		mov al, 180
		mul bl
		sub al, num1
		mov bl, al
		mov al, 180
		mul bl
		mov num1, al


endm

operacionCoseno macro ; Juan
		imprimir msg_cos
endm

operacionTangente macro ; Juan
		imprimir msg_tan
endm

operacionArcsin macro ; Daniela
		imprimir msg_arcsin

endm

operacionArccos macro ; Daniela
		imprimir msg_arccos

endm

operacionArctan macro ; Daniela
		imprimir msg_arctan

endm






.code
; PROCEDIMIENTOS
limpiar proc far
;; codigo proc
	mov ah,00h;	Limpiar Pantalla
	mov al,03h
 	int 10h
	mov cx,02h
ret
endp
Inicio:
	; Colocar apuntador
    mov ax, @data
	mov ds,ax
Menu:
	imprimir new_line
	imprimir mostrarMenu
	pedirNum op_menu
	mov al,op_menu
	; Salto condicional jump equals opci�n n saltar si es igual a la opcion n
	cmp al,1
	je Suma
	cmp al,2
	je Resta
	cmp al,3
	je Division
	cmp al,4
	je Multiplicacion
	cmp al,5
	je Logaritmo
	cmp al,6
	je Modulo
	cmp al,7
	je Potencia
	cmp al,8
	je Raiz
	cmp al,9
	je Seno
	cmp al,10
	je Coseno
	cmp al,11
	je Tangente
	cmp al,12
	je Arcsin
	cmp al,13
	je Arccos
	cmp al,14
	je Arctan
	cmp al,15
	je Salir
	jmp Menu ; Si es alguna otra opci�n, mostrar el menu de nuevo
Salir:
	mov ah,04ch
	int 21h
Suma:
	imprimir msg_op_suma
	pedirNum num1
	pedirNum num2
	operacionSuma
	mov ah,01;pausa y captura de datos
	int 21h
	; cmp al,27 ; ASCII de ESC
	jmp Menu ; usar je para validar que solo con ESC continue a menu, no olvides quitar el comentario de cmp jaja salu2
Resta:
	imprimir msg_op_resta
	pedirNum num1
	pedirNum num2
	operacionResta
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
    jmp Menu
Division:
	imprimir msg_op_div
	pedirNum num1
	pedirNum num2
	operacionDivision
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
    jmp Menu
Multiplicacion:
	imprimir msg_op_multi
	pedirNum num1
	pedirNum num2
	operacionMultiplicacion
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
    jmp Menu
Logaritmo:
	imprimir msg_op_log
	pedirNum num1
	operacionLogaritmo
	int 21h
	jmp Menu
Modulo:
	imprimir msg_op_modulo
	pedirNum num1
	pedirNum num2
	operacionModulo
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Potencia:
	imprimir msg_op_pot
	pedirNum num1
	pedirNum num2
	operacionPotencia
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Raiz:
	imprimir msg_op_raiz
	pedirNum num1
	operacionRaiz
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Seno:
	imprimir msg_op_sen
	pedirNum num1
	operacionSeno
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Coseno:
	imprimir msg_op_cos
	pedirNum num1
	operacionCoseno
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Tangente:
	imprimir msg_op_tan
	pedirNum num1
	operacionTangente
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Arcsin:
	imprimir msg_op_arcsin
	pedirNum num1
	operacionArcsin
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Arccos:
	imprimir msg_op_arccos
	pedirNum num1
	operacionArccos
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
Arctan:
	imprimir msg_op_arctan
	pedirNum num1
	operacionArctan
	mov ah,01; Pausar y pedir un nuevo caracter para continuar, puede ser ESC o cualquiera
	int 21h
	jmp Menu
.exit
end Inicio