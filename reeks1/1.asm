$include (c8051f120.inc)

cseg at 000H
  jmp main

cseg at 050H
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov SFRPAGE,#0Fh
	mov XBR2,#40h
	mov P1MDOUT,#40H
	mov P3MDOUT,#00H

start:
  setb P1.6
