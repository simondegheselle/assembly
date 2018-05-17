$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

	mov R2, #01010001b
	mov B, #00d
	mov R0, #20H
loop:	
	mov R1, #08d
	mov A, @R0
loop2: 
	clr C
	rrc A

	push Acc
	mov A, B
	rlc A

	jnc verder
	
	xrl A, R2 

verder:
	mov B, A
	pop Acc

	djnz R1, loop2	
	
	inc R0
	cjne R0, #31H, loop
