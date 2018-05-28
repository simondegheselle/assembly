
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
  jmp ISR_TR2

cseg at 0073H
  jmp ISR_TR3

cseg at 0080H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA
  setb ET0
  setb ET1
  mov EIE2, #01h

  mov SFRPAGE, #0Fh
  mov XBR2, #40h
  mov P1MDOUT, #80h

  mov SFRPAGE, #00h
  mov TMR2CF, #00h
  mov TMR2H, #06h
  mov TMR2L, #0C6h
  mov RCAP2H, #06h
  mov RCAP2L, #0C6h
  setb TR2

  mov SFRPAGE, #01h

  mov TMR3CF, #00h
  mov TMR3H, #0FEh
  mov TMR3L, #02H
  mov RCAP3H, #0FEh
  mov RCAP3L, #02H
  setb TR3

  clr C

  jmp $

ISR_TR2:
  clr TR2
  clr TF2

  cpl C

  jc naar_laag
  mov RCAP3H, #0FEh
  mov RCAP3L, #02H
  setb TR3

  reti
naar_laag:
  mov RCAP2H, #06h
  mov RCAP2L, #0C6h
  setb TR3
  reti

ISR_TR3:
  mov SFRPAGE, #01h
  clr TF3
  mov SFRPAGE, #00h
  cpl P1.7
  reti
