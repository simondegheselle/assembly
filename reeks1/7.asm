$include (c8051f120.inc)

cseg at 000H
  jmp main

cseg at 050H
main:
  clr EA
  mov WDTCN, #0DEH
  mov WDTCN, #0DAH
  setb EA

  mov SFRPAGE,#0Fh
	mov P1MDOUT,#255d
  mov P3MDOUT,#40H

  mov A, 0000001b

start:
  mov P1, A
  mov R2, #255d
  loop: mov R3, #255d
  djnz R3, $
  djnz R2, loop

  jnb P3.7, ingedrukt # iemand die weet waarom het hier jnb is ipv jb
verder:
  jc naar_links
  jnc naar_rechts

ingedrukt:
  jb P3.7, $
  cpl C
  jmp verder

naar_links:
  rl A
  jmp start

naar_rechts:
  rr A
  jmp start
