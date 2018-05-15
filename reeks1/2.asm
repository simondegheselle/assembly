// Schrijf een programma dat bij het indrukken van de schakelaar, aangesloten op P3.7, het LED op
// P1.6 aan‐ of uitschakelt.

$include (c8051f120.inc)

cseg at 000H
  jmp main

cset at 050H
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov SFRPAGE,#0Fh
	mov XBR2,#40h
	mov P1MDOUT,#01000000b
	mov P1,#40H
  setb P1.6

start:
  mov R2, #255d
  loop: mov R3, #255d
  djnz R3, $
  djnz R2, loop
  cpl P1.6
  jmp start
