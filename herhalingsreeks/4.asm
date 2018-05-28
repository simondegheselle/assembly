; blokgolf van 1kHz
; t = 0,0005 s
; # ticks = f * t = 1531,25 ticks
; 16 bit timer: 65536
; startwaarde: 64005
; 0xFA05
$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 002BH
  jmp ISR_TR2

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA
  setb ET2

  mov SFRPAGE, #0Fh
  mov XBR2, #40h
  mov P1MDOUT, #80h

  mov SFRPAGE, #00h
  mov TMR2CF, #08h
  mov TMR2L, #05h
  mov TMR2H, #0FAh

  mov RCAP2H, #0FAh
  mov RCAP2L, #05h
  setb TR2
  jmp $

ISR_TR2:
  cpl P1.7
  reti