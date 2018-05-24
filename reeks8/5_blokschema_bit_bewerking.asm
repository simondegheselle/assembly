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
loop: mov C, 22H.7
	anl C, P2.3
	cpl C

	mov F1, C

	mov C, P7.1 ; mov bit operaties met carry dus je hebt C nodig
	orl C, F0

	anl C, F1
	mov P0.0, C

	jmp loop
