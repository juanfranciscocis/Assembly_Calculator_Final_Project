 




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
; MACROS

; Este macro imprime un mensaje
imprimir macro dato
    mov ah,09h
    lea dx,dato ; Cargar dato
	int 21h ; Interrupción servicio de video
endm

pedirNum macro dato
	imprimir msg_num
	mov ah,01h
	int 21h
	sub al,30h
	mov dato,al
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
operacionDivision macro
		imprimir msg_div
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
	mov ah,01h ; Pide caracter
	int 21h
	xor ah,ah
	sub al,30h
	; Salto condicional jump equals opción n saltar si es igual a la opcion n
	cmp al,1
	je Suma
	cmp al,2
	je Resta
	cmp al,3
	je Division
	cmp al,4
	je Multiplicacion
	cmp al,5
	je Salir
	jmp Menu ; Si es alguna otra opción, mostrar el menu de nuevo
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
.exit
end Inicio