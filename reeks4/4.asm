$include (c8051f120.inc)

cseg at 0000H
	jmp main

cseg at 000BH
	jmp ISR_T0

cseg at 002BH
	jmp ISR_T2

cseg at 0050H
main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA 
	setb ET0
	setb ET2

 	; poort config
	mov SFRPAGE, #0FH
	mov P1MDOUT, #0FFH

	mov SFRPAGE, #0h 
	mov TMOD, #02h
	mov CKCON, #08h
	mov TH0, #24h
	

	mov TMR2CF, #08h
	mov RCAP2H, #0F4h
	mov RCAP2L, #8h
	setb TR2

	jmp $

ISR_T0:
	cpl P1.6
	reti


ISR_T2:
	cpl P1.7
	reti
