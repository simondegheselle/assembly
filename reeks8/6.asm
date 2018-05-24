; getal in A vermenigvuldigen met 62 en als high byte register B gebruiken
$include (c8051f120.inc)

cseg at 0000H 
	jmp main

cseg at 0050H
main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA
	mov A, #12d
	push Acc
	
	mov R1, #06d
loop: 
	clr C
	rlc A
	push Acc
	mov A, B
	rlc A
	mov B, A
	pop Acc
	djnz R1, loop

	pop 00h

	subb A, R0
	subb A, R0

	jmp $
