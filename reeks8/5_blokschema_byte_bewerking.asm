$include (c8051f120.inc)

cseg at 0000H 
	jmp main

cseg at 0050H
main: 
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA

	mov SFRPAGE, #0Fh
	mov XBR2, #40H
	mov P0MDOUT, #01H
	
	; linksboven
	; als de carry niet gebruikt wordt moet je met bytes werken
loop: 
	mov A, 20H
	rl A ; zorgen dat de 7de bit van 22H op de 3 de bit van de A komt, zodanig dat de anl kan uitgevoerd worden
	rl A
	rl A
	rl A
	anl A, P2
	cpl A
	push Acc
	
	mov A, P7
	rl A
	rl A 
	rl A
	rl A ; 4 keer rl want de eerste bit moet op de 5 de bit komen zodanig dat we kunnen vergelijken met 5 de bit van PSW (F0)

	orl A, PSW
	pop B ; waarde van stack komt ' resultaat eerste NAND bewerking ) in B
	
	rr A
	rr A
	anl A, B

	mov C, Acc.3 ; accumulator is bit addreseerbaar

	jmp loop
