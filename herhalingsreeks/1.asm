; blokgolf van 1kHz
; t = 0,0005 s
; # ticks = f * t = 1531,25 ticks
; met timer 0 in 8 bit mode
; 127,604166666666667
; 128 ticks nodig van de 256
; fout van 0.4 op 256
; startwaarde 80h
$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 000BH
  jmp ISR_TR0

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA
  setb ET0

  mov SFRPAGE, #0Fh
  mov P1MDOUT, #80h

  mov SFRPAGE, #00h
  mov TMOD, #02h
  mov CKCON, #00h
  mov TH0, #80h
  mov TL0, #80h
  setb TR0

ISR_TR0:
  cpl P1.7
  reti