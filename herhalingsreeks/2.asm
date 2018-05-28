; 3 kHz
; 0,000166666666667 seconden timer overflow
; aantal ticks? 510 ticks nodig
; met 16 bit timer 65536 ticks dus voldoende
; wat is de startwaarde
; FFFF - 1FE = FE01

; 1.5 kHz

; t = 0,000333333333333 s
; aantal ticks = t * f = 1021
; timer 3 16 bit timer: 65536 ticks
; delen door 48 21267 ticks over
; start waarde FC02
$include (c8051f120.inc)

cseg at 0000h
  jmp main

cseg at 002Bh
  jmp ISR_TR2

cseg at 0073h
  jmp ISR_TR3

cseg at 0080h
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  setb ET2
  mov EIE2, #01h

  mov SFRPAGE, #00h
  mov TMR2CF, #08h
  mov RCAP2L, #01h
  mov RCAP2H, #0FEh
  setb TR2

  mov SFRPAGE, #01h
  mov TMR3CF, #08h
  mov RCAP3L, #02h
  mov RCAP3H, #0FCh
  setb TR3

  jmp $

ISR_TR2:
  clr TF2
  cpl P1.7
  reti

ISR_TR3:
  crl TF3
  cpl P1.6
  reti