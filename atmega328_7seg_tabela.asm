;
; atmega328p_7seg_tabela.asm
;
; display de sete segmentos
; mapeamento do display bit menos significativo no segmento 'a'
;
; Created: 14/06/2017 23:37:54
; Author : Iran Eletronica
;



	.def	acumulador		= r16			; atribui sinonimos aos registradores de uso geral
	.def	tempo1			= r17
	.def	tempo2			= r18
	.def	digito			= r20			; atribui sinonimos aos registradores de uso geral


	.org					$0000			; vetor de reset, endereco de origem na posicao 0x00 de memoria


;--- configuracao inicial e I/Os---
setup_int:

	ser		acumulador						; carrega 0xFF no acumulador
	out		DDRD, acumulador				; configura todo port D como saida

	ldi		zh, high(mydata<<1)				; inicializa o ponteiro z (high)	
	ldi		zl, low(mydata<<1)				; inicializa o ponteiro z (low)


;--- programa principal ---
contagem:

	lpm		digito, z+						; carrega no r20 o conteudo da posicao do ponteiro
	cpi		digito, 0						; compara o conteudo de r20 com numero zero(ultimo elemento)
	out		PORTD, r20						; escreve o conteudo de r20 na porta d (para a saida)
	call	delay500ms
	rjmp	contagem						; pula para a label contagem



; --- rotina de delay ---

delay500ms:									; medido no proteus 500ms r16=FA  r17=C8
					
		ldi		tempo1,	$FA					; 1 | move o valor 250 decimal para o registrador R16

aux1:
		ldi		tempo2,	$C8					; 1 x 250 | move o valor 200 decimal para o registrador R17
		nop									; 1 x 250 | no operation
		nop									; 1 x 250 | no operation
		nop									; 1 x 250 | no operation
		nop									; 1 x 250 | no operation
		nop									; 1 x 250 | no operation

aux2:
		nop									; 1 x 250 x 200 = 50000 | no operation
		nop									; 1 x 250 x 200 = 50000 | no operation
		nop									; 1 x 250 x 200 = 50000 | no operation
		nop									; 1 x 250 x 200 = 50000 | no operation
		nop									; 1 x 250 x 200 = 50000 | no operation
		nop									; 1 x 250 x 200 = 50000 | no operation

		dec		tempo2						; Decrementa r17
		cpi 	tempo2,	0					; Compara r17 com zero
		brne 	aux2						; 2 x 250 x 200 = 100000	| se R17 for diferente zero pula para aux2
		dec		tempo1						; Decrementa r16
		cpi 	tempo1,	0 					; Compara r16 com zero
		brne 	aux1						; 2 x 250					| se R16 for diferente zero pula para aux1

		ret									; retorna para o loop principal
											;-------------------------------------------------
											; Total = 500005µs ~~ 500ms = 0,5 seg  // meu total=402000us = 0,4ms


////////////////////////////////////////////////////////////////////////////////////////


	.org 0x500								; aponta o endereco inicial da tabela

; tabela de display sete segmentos catodo comum
mydata: .db 63,6,91,79,102,109,125,7,127,111,128,0

; tabela de display sete segmentos anodo comum
;mydata: .db 64,121,36,48,25,18,2,120,128,16,127,0


