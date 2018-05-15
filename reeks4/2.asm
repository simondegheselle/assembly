cseg at 0000H
  jmp main

# catch external interrupt 1
cseg at 0013H
  jmp ISR_EX1

cseg at 0050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0ADH
  setb EA
  setb EX1 # enable interupt 1

  mov SFRPAGE, #0FH
  mov XBR2, #40H # configure crossbar
  mov XBR1, #10H

  # ...
  mov P0MDOUT, #0F0h
  mov P1MDOUT, #0FFh
  clr P0.4

  mov R1, #0d
  jmp $

ISR_EX1:
  inc R2
  cjne R2, #10d, verder

  mov R2, #0d
  cpl P1.6


verder:

start_loop:
  mov R3, #255d
loop:
  R4, #255d
  djnz R4, $
  djnz R3, loop
	jnb P0.0, start_loop

  reti
