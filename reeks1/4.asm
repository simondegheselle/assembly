$include (c8051f120.inc)

cseg at 000H
  jmp main

cseg at 050H
main:
  clr EA
  mov WDTCN, 0DEH
  mov WDTCN, 0ADH
  setb EA

  mov SFRPAGE,#0Fh
	mov P1MDOUT,#40H
	mov P3MDOUT,#00H

  mov R3, #0H

start:
  jb P3.7, $
  jnb P3.7, $
  inc R3
  inc R3
  mov R4, R3

  brand_licht:
  mov R0, #255
  loop mov R1, #255
  djnz R1, $
  djnz R0, loop
  cpl P1.6

  dnjz R3, brand_licht

  mov R3, R4

  jmp start
