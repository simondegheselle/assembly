$include (c8051f120.inc)

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
  mov P1MDOUT, #0FFh
  mov P0MDOUT, #11110000b

start:
  mov P0, #0F0h

  clr P0.4
  jnb P0.0, _0
  jnb P0.1, _4
  jnb P0.2, _8
  jnb P0.3, _12
  setb P0.4

  clr P0.5
  jnb P0.0, _1
  jnb P0.1, _5
  jnb P0.2, _9
  jnb P0.3, _13
  setb P0.5

  clr P0.6
  jnb P0.0, _2
  jnb P0.1, _6
  jnb P0.2, _10
  jnb P0.3, _14
  setb P0.6

  clr P0.7
  jnb P0.0, _3
  jnb P0.1, _7
  jnb P0.2, _11
  jnb P0.3, _15
  setb P0.7

  jmp start

_0:
  ; toon
  jmp start

_1:
  ; toon
  jmp start

_2:
  ; toon
  jmp start

_3:
  ; toon
  jmp start

_4:
  ; toon
  jmp start

;....
