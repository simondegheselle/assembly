$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0080H
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov SFRPAGE, #0FH
  mov P0MDOUT, #0FFh
  mov P1MDOUT, #0FFh

  mov SFRPAGE, #00H
  mov 20H, #0111111b
  mov 21H, #0000110b
  mov 22H, #1011011b
  mov 23H, #1001111b
  mov 24H, #1100110b
  mov 25H, #1101101b
	mov 26H, #1111101b
	mov 27H, #0000111b
	mov 28H, #1111111b
	mov 29H, #1101111b

  mov REF0CN, #07h # referentiespanning aanzetten
  mov R2, #255d
  loop: mov R3, #255d
  djnz R3, $
  djnz R2, loop

  mov AMX0SL, #80H # temperatuur sensor selecteren
  mov AMX0CF, #00h # single ended instellen
  setb AD0EN # converter blijft aanstaan

start_conversie:
  clr AD0INT
  setb ADOBUSY
  jnb ADOINT, $

  mov A, ADCOL
  sub A, #64H
  mov B, #5d
  div AB

  # hier snap ik niet wat hij precies doet
  push Acc # waarde van de accumulator op de stack zetten
  mov A, B
	rl A
	mov R6, A
	pop Acc
	add A, #15d
  # #######################################

  # getal opdelen in 2 afzonderlijke getallen
	mov B, #10d
	div AB

	mov R5, B
	mov R4, A


uitschrijven:
	mov A, #20H	; basis adres
	add A, R5
	mov R0, A
	mov sfrpage, #0Fh
	mov P1, @R0

	mov A, #20H
	add A, R4
	mov R0, A
	mov P2, @R0

	jmp start_conversie
