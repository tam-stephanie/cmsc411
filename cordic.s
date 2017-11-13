SINE:
    .word   0.707
    .word   0.448
    .word   0.242
    .word   0.124
    .word   0.063
    .word   0.0314
    .word   0.016
    .word   0.007
    .word   0.0035
    .word   0.0017

COSINE:
    .word   0.707
    .word   0.894
    .word   0.970
    .word   0.992
    .word   0.998
    .word   0.999
    .word   1
    .word   1
    .word   1
    .word   1

TANGENT:
    .word   1
    .word   0.5
    .word   0.25
    .word   0.125
    .word   0.0625
    .word   0.03125
    .word   0.015635
    .word   0.0078125
    .word   0.00390625
    .word   0.001953125

TAN_ANGLES:
    .word   45.0
    .word   26.6
    .word   14.0
    .word   7.1
    .word   3.6
    .word   1.8
    .word   0.9
    .word   0.4
    .word   0.2
    .word   0.1

cordic:
    STR     R0, [ , #0]
    STR     R1,
    STR     R2,


main:
