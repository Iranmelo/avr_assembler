;
; atmega8a_blink.asm
;
; MCU atmega8a clock: 1mhz
;
; Created: 23/08/2020 23:08:42
; Author : Iran Eletronica
;


.def AUX = R16							;; R16 tem agora o nome de AUX

.ORG 0x0000                 ;; vetor de reset

inicio:

	LDI		AUX,0x04					  ;; inicializacao do Stack Pointer na posição 0x045F da SRAM (Topo)
	OUT		SPH,AUX						  ;; registrador SPH = 0x04
	LDI		AUX,0x5F
	OUT		SPL,AUX						  ;; registrador SPL = 0x5F


	LDI		AUX,0xFF					  ;; carrega AUX com o valor 255 (1 saida 0 entrada)
	OUT		DDRD,AUX					  ;; configura porta D como saida


principal:
	
	LDI		AUX,0x0F
	OUT		PORTD,AUX
	RCALL	atraso
	RCALL	atraso

	LDI		AUX,0xF0
	OUT		PORTD,AUX
	RCALL	atraso
	RCALL	atraso

	RJMP principal

;;------------------------------------------------------------------------------------------------
;; SUB-ROTINA DE ATRASO - Aprox. 0,4 s à 1 MHz
;;------------------------------------------------------------------------------------------------

atraso:

	LDI		R17,0xFF					;; carrega 255 em R17
	LDI		R18,0xFF					;; carrega 255 em R18
	LDI		R19,0x02					;; repete os laços abaixo 2 vezes

volta:

	DEC		R17							  ;; decrementa R17
	BRNE	volta						  ;; enquanto R17 > 0 fica decrementando R17

	DEC		R18							  ;; decrementa R18
	BRNE	volta						  ;; enquanto R18 > 0 volta decrementar R17

	DEC		R19							  ;; decrementa R19, começa com 0x02
	BRNE	volta
	RET									    ;; retorna da subrotina

