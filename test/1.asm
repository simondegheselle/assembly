$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA

  mov SFRPAGE, #0Fh
  mov XBR2, #40h
  mov P1MDOUT, #40h

start:
  mov C, P1.0
  anl C, F0
  push Cy

  mov C, 22H.7
  orl C, F1
  mov Acc.0, C
  pop Cy

  xrl C, Acc.0
  mov P1.6, C

  jmp start
