; 3062500
; met een 16-bit timer 0
; 65536 ticks
; delen door 48
; 63802, 08333 ticks nodig
; fout van 0,08 op 63802 << heel klein
; startwaarde 0x6C5
include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA

  mov SFRPAGE, #0Fh
  mov XBR2, #40h
  mov P1MDOUT, #40h

  mov SFRPAGE, #00h
  mov TMOD, #01h
  mov CKCON, #02h
  mov TL0, #06h
  mov TH0, #0C5h
  setb TR0

start:
  jnb TF0, $
  clr TF0
  clr TR0

  cpl P1.6
  mov TL0, #03Ah
  mov TH0, #0F9h
  setb TR0
  jmp start
