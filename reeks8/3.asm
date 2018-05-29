cseg at 0000H
  jmp main

cseg at 0050H

main:
  clr EA
  mov WDTCN,#0DEh
  mov WDTCN,#0ADh
  setb EA

verm:
  mov 30H, #251d
  mov 31H, #254d

  mov 32H, #00d
  mov 33H,#00H
  mov A, 30H
loop:
  clr C
  rrc A
  mov 30H, A
  jnc verder
  clr C

  mov A, 31H
  add A, 33H
  mov 33H, A
  mov A, 32H
  addc A, 34H
  mov 34H, A
verder: clr C
  mov A, 31H
  rlc
  mov 31H, A
  mov A, 32H
  rlc A
  mov 32H, A
  mov A, 30H
  jnz loop
  mov A, 33H
  mov B, 34H
  ret
