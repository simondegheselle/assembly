cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0DAH
  setb EA

  mov SFRPAGE, #0Fh
	mov XBR2, #40h

  mov P1MDOUT, 0FFH

start:
  // aan toine vragen