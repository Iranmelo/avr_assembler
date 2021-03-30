;
; attiny2313_blink.asm
;
; Created: 25/02/2017 19:26:19
; Author : Iran Eletronica
;
; MCU: ATtiny2313A	CLOCK: 1Mhz		Ciclo da maquina: 1us (1/F_CPU)
;
; pisca um led no pino PD0


.org $0000							              ; origem endereco de memoria
									

; --- configurando as saidas ---

	ldi		r16,	(1 << PD0)		          ; define pull-ups e seta a saida
	ldi		r17,	(1 << DDD0)		          ; define a direcao do  pino
	out		PORTD,	r16				            ; ativa o reistor pull-up no pino PB0 
	out		DDRD,	r17				              ; define PB0 como saida

; --- laco principal ---
loop:
	
	clr		r16
	clr		r17						                ; limpa os registradores para nova interacao

	cbi		PORTD,	PORTD0			          ; limpa o bit em PB0 / constante $0 bit 0
	rjmp	delay500ms				            ; chama a subrotina

setport0:	
	sbi		PORTD,	PORTD0			          ; seta o bit em PB0
	rjmp	delay500ms				            ; chama a subrotina

	
; --- rotina de delay ---

delay500ms:							              ; medido no proteus 500ms r16=FA  r17=C8
					
		ldi		r16,	$FA			              ; 1 | move o valor 250 decimal para o registrador R16

aux1:
		ldi		r17,	$C8			              ; 1 x 250 | move o valor 200 decimal para o registrador R17
		nop							                  ; 1 x 250 | no operation
		nop							                  ; 1 x 250 | no operation
		nop							                  ; 1 x 250 | no operation
		nop							                  ; 1 x 250 | no operation
		nop							                  ; 1 x 250 | no operation

aux2:
		nop							                  ; 1 x 250 x 200 = 50000 | no operation
		nop							                  ; 1 x 250 x 200 = 50000 | no operation
		nop							                  ; 1 x 250 x 200 = 50000 | no operation
		nop							                  ; 1 x 250 x 200 = 50000 | no operation
		nop							                  ; 1 x 250 x 200 = 50000 | no operation
		nop							                  ; 1 x 250 x 200 = 50000 | no operation

		dec		r17					                ; Decrementa r17
		cpi 	r17,	0			                ; Compara r17 com zero
		brne 	aux2				                ; 2 x 250 x 200 = 100000	| se R17 for diferente zero pula para aux2
		dec		r16					                ; Decrementa r16
		cpi 	r16,	0 			              ; Compara r16 com zero
		brne 	aux1				                ; 2 x 250					| se R16 for diferente zero pula para aux1

		sbic	PORTD,	$0			            ; testa de PB0 eh zero, se verdadeiro pula uma linha
		rjmp	loop				                ; pula para a label loop
		rjmp	setport0			              ; pula para a label setport0

	;	ret							                  ; retorna da interrupcao
	
									;-------------------------------------------------
									; Total = 500005µs ~~ 500ms = 0,5 seg  // meu total=402000us = 0,4ms


; Instrucoes utilizadas

;	LDI – Load Immediate........................................115
;	OUT – Store Register to I/O Location........................134
;	CLR – Clear Register........................................ 71	
;	CBI – Clear Bit in I/O Register..............................65
;	CALL – Long Call to a Subroutine............................ 63				
;	SBI – Set Bit in I/O Register.............................. 151
;	RJMP – Relative Jump....................................... 142
;	NOP – No Operation......................................... 131
;	DEC – Decrement............................................. 84
;	CPI – Compare with Immediate.................................81
;	BRNE – Branch if Not Equal...................................54
;	RET – Return from Subroutine............................... 139

									
