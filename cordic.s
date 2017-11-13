    .data
@SINE:
@    DCD   0.707, 0.448, 0.242, 0.124, 0.063, 0.0314, 0.016, 0.007, 0.0035, 0.0017

@COSINE:
@    DCD   0.707, 0.894, 0.970, 0.992, 0.998, 0.999, 1, 1, 1, 1

TANGENT:
    DCD   1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015635, 0.0078125, 0.00390625, 0.001953125

TAN_ANGLES:
    DCD   45.0, 26.6, 14.0, 7.1, 3.6, 1.8, 0.9, 0.4, 0.2, 0.1

@ x value
GAIN:  DCD   0.607


    .text
cordic:
    @ store pointers to lookups
      LDR   R0, PC, #SINE
      LDR   R1, PC, #COSINE
      LDR   R2, PC, #TANGENT

    @ handle constants
    MOV     R6, #0               @ counter
    MOV     R7, #10              @ size of array of angles
    LDR     R2, []

    STR     R1, []
    STR     reg, target          @ store target angle
    LDR     currSin, #0
    STR     R2,


@ putting in pseudocode for now
cordic_for_loop:
    CMP     currAngle, 0
    BGT     otherCalcVer

    @inside 'if' in py --> x+y<<i
    LSL

otherCalcVer:



main:
