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
  push Acc
  push Acc

  mov R2, #06d
    rlc A
    push Acc
    mov A, B
    rlc B
    mov B, A
    pop Acc
  djnz R2, loop

  pop 00h
  subb A, R0
  subb A, R0

  pop 00h
  push Acc
  mov A, R0
  rr A
  rr A
  rr A
  mov R0, A
  pop Acc

  subb A, R0
  subb A, R0
  subb A, R0

  jmp $