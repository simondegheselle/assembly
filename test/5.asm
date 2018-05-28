$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA

  mov R0, #40h
  push 00h

  mov R0, 0d
  push 00h

  call bereken_lengte
  mov SP, #07h
  jmp $

bereken_lengte:
  push 00h
  mov R0, SP
  dec R0
  dec R0
  dec R0

  push 01h
  mov R1, @R0
  dec R0

  push 02h
  mov R2, @R0
  mov A, R2

  jnz rec

  pop 02h
  pop 01h
  pop 00h
  reti

rec:
  inc R1
  inc R2
  push 02h
  push 01h
  call bereken_lengte

  pop 02h
  pop 01h
  pop 00h
  reti