;Schrijf een programma dat 2 getallen kleiner dan 10 inleest van het toetsenbord en de som op de
;LED‐bar afdrukt.
$include (c8051f120.inc)
cseg at 0000H
    jmp main
cseg at 0050H
main:
    clr EA ;disable interrupts
    mov WDTCN, #0DEh ;disable watchdog timer
    mov WDTCN, #0ADh
    setb EA ; re-enable interrupts

    ;om de poorten in te stellen en de crossbar aan te zetten moeten we op de juiste SFR pagina zitten
    mov SFRPAGE, #0Fh
    ;zet crossbar aan
    mov XBR2, #40h
    ;configureer de poorten
    ;P0 : 4 input (=0) 4 output pinnen (=1)
    mov P0MDOUT, #11110000b
    ;P1: allemaal output (=0)
    mov P1MDOUT, #0FFh

start:
    mov R2, #2d
scan:
    mov P0, #0FFh ; zet alle pinnen op 1 (de inputs stonden al op 1) zodat we de
    ;outputs 1 voor 1 op nul kunnen zetten en het toetsenbord kunnen pollen

    clr P0.4
    jnb P0.0, _0 ;als de poort op 0 staat is ze ingedrukt en moet de eerste waarde 0 zijn
    jnb P0.1, _4
    jnb P0.2, _8
    setb P0.4

    clr P0.5
    jnb P0.0, _1
    jnb P0.1, _5
    jnb P0.2, _9
    setb P0.5

    clr P0.6
    jnb P0.0, _2
    jnb P0.1, _6
    setb P0.6

    clr P0.7
    jnb P0.0, _3
    jnb P0.1, _7
    setb P0.7

    jmp scan

show:
    djnz R2, scan
    mov P1, A
    jmp start

_0:
    add A, #0d
    jmp show
_1:
    add A, #1d
    jmp show
_2:
    add A, #2d
    jmp show
_3:
    add A, #3d
    jmp show
_4:
    add A, #4d
    jmp show
_5:
    add A, #5d
    jmp show
_6:
    add A, #6d
    jmp show
_7:
    add A, #7d
    jmp show
_8:
    add A, #8d
    jmp show
_9:
    add A, #9d
    jmp show