cseg at 0000H
  jmp main

cseg at 000BH
  jmp ITO

cseg at 0003H
  jmp ISR_EX0

cseg at 0013
  jmp ISR_EX1

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA
  setb EX0
  setb EX1
  setb ET0

  mov SFRPAGE, #0FH
  mov XBR2, #40H
  mov XBR1, #14H

  # ...
  mov P0MDOUT, #0F0h
	mov P1MDOUT, #0FFh
	clr P0.4

  mov P1MDOUT, #0FFh
  mov P2MDOUT, #0FFh
  mov P3MDOUT, #0FFh
  mov P4MDOUT, #0FFh

  mov SFRPAGE, #00h
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

  mov R2, #0d
  mov R3, #0d
  mov R4, #0d
  mov R5, #0d

  jmp $

ITO:
  clr TF0
  mov TH0, #0F4H
  mov TL0, #08Hs

  inc R2

  cjne R2, #10d, uitschrijven1
  mov R2, #0d
  inc R3
  cjne R3, #10d, uitschrijven2
  mov R3, #0d
  inc R4
  cjne R4, #10d, uitschrijven3
  mov R4, #0d
  inc R5
  cjne R5, #10d, uitschrijven3
  mov R5, #0d


  uitschrijven4:
  mov A, H20
  add A, R5
  mov RO, A
  mov P4, @R0

  uitschrijven3:
  mov A, H20
  add A, R4
  mov RO, A
  mov P3, @R0

  uitschrijven2:
  mov A, H20
  add A, R3
  mov RO, A
  mov P2, @R0

  uitschrijven1:
  mov A, H20
  add A, R2
  mov RO, A
  mov P1, @R0

  reti

ISR_EX0:
  mov CKCON, #08H
  mov TMOD, #01H
  mov TH0, #0F4H
  mov TL0, #08H
  setb TR0

  reti

ISR_EX1:
  clr TR0
  reti
