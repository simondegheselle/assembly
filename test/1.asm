$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA

start:
  mov C, P1.0
  anl C, F0
  push Cy

  mov C, 22H.7
  orl C, F1
  mov F0, C
  pop Cy

  xrl C, F0
  mov P1.6, C

  jmp start
