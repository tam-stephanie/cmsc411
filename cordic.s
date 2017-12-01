.data
@ Multiply each piece of data by 2^16=65536 to forego using floating point
@   registers and have extra precision.

values_store:
  .skip 100

@ gainConstant = 0.6072529350
currCos:  @ x
  .int  39796

currSin:  @ y
  .int  0

@ Original Angles:
@   45.0, 26.565, 14.0362, 7.12502, 3.57633, 1.78991, 0.895174
@   0.447614, 0.223811, 0.111906, 0.055953, 0.027977
angles:
  .int  2949120, 1740963, 919876, 466945, 234378, 117303, 58666
  .int  29334, 14667, 7333, 3666, 1833

@ Number of angles & iterations
iter:
  .int  12

@ Test angle, z
currAngle:
  @.int  347039       @ z=5.2954
  @.int  5249433      @ z=80.1
  @.int  1587937      @ z=24.23
  @.int  3179806      @ z=48.52
  @.int  655425       @ z=10.001
  @.int  4643985      @ z=70.86159
  @.int  1966080      @ z=30.0
  @.int  5668864      @ z=86.5
  @.int  5898240      @ z=90
  @.int  0            @ z=0
  @.int  286180       @ z=4.36677
  @.int  2949120      @ z=45
  .int  3932160      @ z=60

  @.int  5881856      @ z=89.75      (cos=0.989; sin=0.917)
  @.int  241172       @ z=3.68      (cos=0.749; sin=0.747)
  @.int  5832310      @ z=88.994    (cos=0.7015; sin=0.938)
  @.int  89926        @ z=1.37217   (cos=0.938; sin=0.131)
  @.int  268894       @ z=4.103     (cos=0.934; sin=0.864)


@ SEE FINAL REPORT FOR SOURCES USED
.text
main:
  LDR    R0, =iter           @ load & store number of iterations
  LDR    R2, [R0]
  SUB    R2, R2, #1          @ size - 1 to not go out-of-bounds
  MOV    R1, #0              @ for-loop counter, i

  LDR    R0, =currAngle      @ load & store currAngle
  LDR    R3, [R0]
  LDR    R0, =currCos        @ load & store currCos
  LDR    R4, [R0]
  LDR    R0, =currSin        @ load & store currSin
  LDR    R5, [R0]
  LDR    R0, =angles         @ load angles[]

@ Handle edge cases
currAngle0:
  CMP    R3, #0              @ if currAngle = 0
  BNE    currAngle90
  MOV    R4, #1              @ currCos = 1
  MOV    R5, #0              @ currSin = 0
  MOV    R0, #0              @ tangent = 0
  B      exit
currAngle90:
  CMP    R3, #90             @ if currAngle = 90
  BNE    for_loop
  MOV    R4, #0              @ currCos = 0
  MOV    R5, #1              @ currSin = 1
  MOV    R0, #0              @ tangent = UNDEFINED
  B      exit

@ Back to main part of code
for_loop:
  MOV    R6, R1
  LDR    R7, [R0, R6, LSL#2] @ get angles[i] w/ offset

  MOV    R8, R4              @ tempCos <-- currCos
  MOV    R9, R5              @ tempSin <-- currSin
  LSR    R8, R1              @ tempCos >> i
  LSR    R9, R1              @ tempSin >> i
  CMP    R3, #0              @ jump to appropriate section
  BGT    else

if:                          @ if currAngle <= 0
  ADD    R3, R3, R7          @ currAngle += angles[i]
  ADD    R4, R4, R9          @ currCos = currCos + tempSin
  SUB    R5, R5, R8          @ currSin = currSin - tempCos
  B      end_elif

else:                        @ if currAngle > 0
  SUB    R3, R3, R7          @ currAngle -= angles[i]
  SUB    R4, R4, R9          @ currCos = currCos - tempSin
  ADD    R5, R5, R8          @ currSin = currSin + tempCos

end_elif:
  ADD    R1, R1, #1          @ increment loop counter
  CMP    R1, R2              @ compare to make sure at right iteration
  BNE    for_loop


@ division to calculate tan(z) = sin(z)/cos(z)
tan_div:
  MOV    R1, R5              @ move sin and cos into R1 and R2
  MOV    R2, R4
  MOV    R1, R1, LSR #4      @ shift right 4 so we don't shift more than 32 left, total
  CMP    R2, #0              @ check for divide by zero!
  BEQ    divide_end

  MOV    R0, #0              @ clear R0 to accumulate result
  MOV    R3, #1              @ set bit 0 in R3, which will be shifted left then right
  LSL    R3, #16

start:
  CMP    R2, R1
  MOVLS  R2, R2, LSL #1      @ shift R2 left until it is about to be bigger than R1
  MOVLS  R3, R3, LSL #1      @ shift R3 left in parallel in order to flag how far we have to go (also indicates # of iterations)
  BLS    start

next:
  CMP    R1, R2              @ carry set if R1 > R2
  SUBCS  R1, R1, R2          @ R1 - R2, if it would give a positive answer
  ADDCS  R0, R0, R3          @ add the current bit in R3 to accumulating answer in R0

  MOVS   R3, R3, LSR #1      @ shift R3 right into carry flag
  MOVCC  R2, R2, LSR #1      @ if R3 bit0 = 0, shift R2 right
  BCC    next                @ if carry not clear, R3 shifted back to where it started, then end

divide_end:
  MOV    R0, R0, LSL #4     @ must shift back since initially shifting by 4 bits

exit:
  LDR    R9, =values_store   @ store values in "array" in mem
  STR    R4, [R9]
  STR    R5, [R9, #4]
  STR    R0, [R9, #8]

  SWI   0x11
