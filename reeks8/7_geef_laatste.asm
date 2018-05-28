$include (c8051f120.inc)

cseg at 0000H
	jmp main

cseg at 0050H
main:
	clr EA
	mov WDTCN, #0DEH
	mov WDTCN, #0ADH
	setb EA

	mov 30H, #01d
	mov 31H, #02d
	mov 32H, #03d

	mov R0, #30H
	push 00H

	mov R0, #3d
	push 00H

	push R0, #40H
	push 00H

	call geef_laatste

	mov SP, #07H
	jmp $

geef_laatste:
	push 00h
	mov R0, SP
	dec R0
	dec R0
	dec R0

	; nu wijs R0 naar eerste argument
	push 01H
	mov R1, @R0
	dec R0

	push 02H ; R2 gebruiken we dus moet op de stapel gezet worden
	mov R2, @R0
	dec R0

	mov A, @R0

 	dec R2 ; R2 = n - 1
	add A, R2

	mov R0, A

	mov A, @R0
	mov @R1, A


	pop 02H
	pop 01H
	pop 00H
	ret
