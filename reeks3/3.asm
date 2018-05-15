$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA

  mov SFRPAGE, #0Fh
  mov P0MDOUT, #0FFH
  mov P1MDOUT, #0FFH
  mov P2MDOUT, #0FFH
  mov P3MDOUT, #0FFH

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

  mov CKCON, #02H
  mov TMOD, #01H
  mov TH0, #06H
  mov TL0, #0C6H

  setb TR0

  mov P0, 20H
  mov P1, 20H
  mov P2, 20H
  mov P3, 20H

  mov R2, #0d
  mov R3, #0d
  mov R4, #0d
  mov R5, #0d

start:
  jnb TF0, $
  clr TF0
  mov TH0, #06H
  mov TL0, #0C6H

  inc R2

  cjne R2, #10d, uitschrijven1
  mov R2, #0d
  inc R3
  cjne R3, #6d, uitschrijven2
  mov R3, #0d
  inc R4
  cjne R4, #10d, uitschrijven3
  mov R4, #0d
  inc R5

  cjne R5, #6d, uitschrijven4
  mov R5, #0d

uitschrijven4:
  mov A, 20H
  add A, R5
  mov R0, A
  mov P2, @R0

uitschrijven3:
  mov A, 20H
  add A, R4
  mov R0, A
  mov P2, @R0

uitschrijven2:
  mov A, 20H
  add A, R3
  mov R0, A
  mov P1, @R0

uitschrijven1:
  mov A, 20H
  add A, R2
  mov R0, A
  mov P0, @R0
  jmp start
