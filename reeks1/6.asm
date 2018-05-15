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

  mov A, 0000001b

start:
  mov P1, A

  mov R1, #255d
  loop: mov R2, #255d
  djnz R2, $
  djnz R1, loop

  rl A
  jmp start
