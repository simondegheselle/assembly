$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA

  ; resultaat
  mov 30H, #00h ; MSB
  mov 31H, #00h
  mov 32H, #00h
  mov 33H, #00h
  mov 34H, #00h
  mov 35H, #00h
  mov 36H, #00h
  mov 37H, #00h ; LSB

  ; doorschuif registers
  mov 38H, #00h ; MSB
  mov 39H, #00h
  mov 40H, #00h
  mov 41H, #00h ; LSB

  ; mutliplicant
  mov 42H, #00h ; MSB
  mov 43H, #00h
  mov 44H, #00h
  mov 45H, #00h ; LSB

  ; multiplier
  mov 46H, #00h ; MSB
  mov 47H, #00h
  mov 48H, #00h
  mov 49H, #00h ; LSB

start:
  ; multiplier naar rechts schuiven

  clr C
  mov R0, #46H
schuif_multiplier:
  mov A, @R0
  rrc A
  mov @R0, A
  inc R0
  cjne R0, #50h, schuif_multiplier

  jnc verder

  mov R0, #37h
  mov R1, #45h
  clr C
tel_op:
  mov A, @R0
  addc A, @R1
  mov @R0, A
  dec R0
  dec R1
  cjne R0, #29h, tel_op

verder:
  clr C
  mov R0, #45h
schuif_mutliplicant:
  mov A, @R0
  rlc A
  mov @R0, A
  dec R0
  cjne R0, #37h, schuif_mutliplicant

  ; check eindconditie en jmp naar start

  jmp $