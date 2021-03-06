
; omschakelen om 250 ms
; daarvoor gebruiken we timer 0
; aantal nodige ticks
; t * f = 0,250 * f = 765625 ticks
; 16 bit timer: 65536
; 8 bit timer: 256 ticks
; frequentie delen door 12
; 63802,08333 ticks nodig
; 63802 ticks
; startwaarde = 1734 = 6C6h

; 3kHz
; 510 ticks nodig
; startwaarde 65026 = FE02

; 255 ticks nodig
$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 000BH
  jmp ISR_TR0

cseg at 001BH
  jmp ISR_TR1

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA
  setb ET0
  setb ET1

  mov SFRPAGE, #0Fh
  mov P1MDOUT, #80h

  mov SFRPAGE, #00h
  mov TMOD, #11h
  mov CKCON, #00h
  mov TH0, #06h
  mov TL0, #0C6h
  setb TR0

  mov TH1, #0FEh
  mov TL1, #02H
  setb TR1

  clr C

  jmp $

ISR_TR0:
  clr TR1
  clr TF1

  cpl C

  jc naar_laag

  mov TH1, #0FEh
  mov TL1, #02H
  setb TR1
  reti
naar_laag:
  mov TH1, #00h
  mov TL1, #0ABH
  setb TR1
  reti

ISR_TR1:
  clr TR1

  cpl P1.7
  jc naar_laag

  mov TH1, #0FEh
  mov TL1, #02H
  setb TR1
  reti
naar_laag:
  mov TH1, #00h
  mov TL1, #0ABH
  setb TR1
  reti
