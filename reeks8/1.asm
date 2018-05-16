$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov R1, #5d
  mov R2, #10d
  push R1
  push R2

  call verm
  mov SP, #07H # stack leegmaken

  jmp $

verm:
  push 00h
  mov R0, SP
  dec R0
  dec R0
  dec R0

  mov A, @R0
  dec R0
  mov B, @R0
  mul AB
  pop 00h
  ret