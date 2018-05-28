; omschakelen om 0.7ms
; aantal ticks = 0,0007 * f = 2143,75
; 2144 = 0x860
; FFFF - 860 = 0xF79F
$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0073h
  jmp ISR_TR3

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA
  mov EIE2, #01h

  mov TMR3CF, #08h
  mov RCAP3L, #9Fh
  mov RCAP3H, #0F7h
  mov TMR3L, #9Fh
  mov TMR3H, #0F7h

  setb TR3

start:
  jc msb_naar_buiten
  jnc lsb_naar_buiten

msb_naar_buiten:
  clr C
  mov A, R0
  rrc
  mov P1.7, C
  rlc
  jmp start
lsb_naar_buiten:
  clr C
  mov A, R0
  rlc
  mov P1.7, C
  rrc
  jmp start

ISR_TR3:
  clr TF3
  cpl C
  reti