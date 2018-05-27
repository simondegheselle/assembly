; t = 1 s
; f * t = 3062500
; 16-bit timer: # ticks 65536
; 63802 = 0xF93A
; startwaarde 0x6C5
$include (c8051f120.inc)

cseg at 0000H
  jmp main

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov SFRPAGE, #0Fh
  mov P0MDOUT, #0FFh
  mov P1MDOUT, #0FFh
  mov P2MDOUT, #0FFh
  mov P3MDOUT, #0FFh

  mov SFRPAGE, #00h
  mov 20H, #0111111b
  mov 21H, #0000110b
  mov 22H, #1011011b
  mov 23H, #1001111b
  mov 24H, #1100110b
  mov 25H, #1101101b
  mov 26H, #1111101b
  mov 27H, #0000111b
  mov 28H, #1111111b
  mov 29H, #1101111b

  mov R1, #0d
  mov R2, #0d
  mov R3, #0d
  mov R4, #0d

  mov TMOD, #01h
  mov CKCON, #02h
  mov TL0, #0C5h
  mov TH0, #06h
  setb TR0

start:
  jnb TF0, $
  clr TF0
  clr TR0

  inc R1
  cjne R1, #60d, skip
  mov R1, #0d

  inc R2
  cjne R2, #10d, uitschrijven4
  mov R2, #0d
  inc R3
  cjne R3, #6d, uitschrijven3
  mov R3, #0d
  inc R4
  cjne R4, #24d, uitschrijven_uren

uitschrijven_uren:
  mov A, R4
  mov B, #10d
  div AB
  # A bevat 1ste decimaal uren
  # B bevat 2de decimaal uren
  add A, #20h
  mov R0, A
  mov P3, @R0

  mov A, B
  add A, #20h
  mov R0, A
  mov P2, @R0

uitschrijven3:
  mov A, 20h
  add A, R3
  mov R0, A
  mov P1, @R0

uitschrijven4:
  mov A, 20h
  add A, R2
  mov R0, A
  mov P0, @R0

skip:
  mov TL0, #0C5h
  mov TH0, #06h
  setb TR0
  jmp start
