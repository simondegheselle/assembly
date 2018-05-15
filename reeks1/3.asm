$include (c8051f120.inc)

cseg at 000H:
  jmp main

cseg at 050H:
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADH
  setb EA

  mov SFRPAGE,#0Fh
	mov P1MDOUT,#40H
	mov P3MDOUT,#00H

start:
  jb P3.7, $
  cpl P1.6
  jnb P3.7, $
  jmp start
