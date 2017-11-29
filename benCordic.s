.data
currCos:   @ 1.646768 * 2^16
  @.int  107922
  .int	39796
 @ 1.646768
currSin:
  .int 0

angles:   @ took original angles and manually multiplied by 2^16
  .int  2949120, 1740963, 919876, 466945, 234378, 117303
  .int	58666, 29294, 14667, 7333

iter:
  .int 10                   @ number of angles & iterations

currAngle:  @ x * 2^16
  @.int  5249433
  .int 2641100


.text
main:
  LDR   R0, =iter           @ load addresses
  LDR   R2, [R0]            @ store number of iterations
  SUB   R2, R2, #1			@ We only want to count up to one before the actual number of iterations
  MOV   R1, #0              @ for-loop counter

  LDR   R0, =currAngle      @ load address of test angle
  LDR   R3, [R0]            @ store angle
  LDR   R0, =currCos        @ load currCos
  LDR   R4, [R0]            @ store currCos
  LDR   R0, =currSin        @ load currSin
  LDR   R5, [R0]            @ store currSin
  LDR   R0, =angles         @ load tangent angles

for_loop:
  CMP   R1, R2              @ compare to make sure loop works
  BGE   end

  mov   R6, R1				@ Move our counter in to a temp register to offset
  LSL	R6, #2				@ offset by a byte
  LDR   R7, [R0, R6]        @ get angles[i]
  

  CMP   R3, #0
  BGT    else               @ jump to 'else' part

if:                         @ if currAngle <= 0
  ADD   R3, R3, R7          @ currAngle += angles[i]
 @ ASR   R5, #16              @ shift right by 16 bits, not sure about arithmetic or logical

  MOV	R8, R4				@ temp cosine <- cosine
  MOV	R9, R5				@ temp sine <- sine
  LSR	R8, R1				@ temp cosine >> i
  LSR	R9, R1				@ temp sine >> i
  ADD	R4, R4, R9			@ cosine = cosine + (temp sine >> i)
  SUB	R5, R5, R8			@ sine   = sine   - (temp cosine >> i)

  @ASR	R5, R1
  @ADD   R4, R4, R5          @ newCos = currCos + (currSin * 2.0**(-i))
  @ASR   R4, R1
  @SUB   R5, R5, R4          @ newSin = currSin - (currCos * 2.0**(-i))
  @MOV   R4, R8				 @ store new values
  @MOV   R5, R9

  ADD   R1, R1, #1          @ increment loop counter
  b for_loop

else:                       @ if currAngle > 0
  SUB   R3, R3, R7          @ currAngle -= angles[i]

  MOV	R8, R4				@ temp cosine <- cosine
  MOV	R9, R5				@ temp sine <- sine
  LSR	R8, R1				@ temp cosine >> i
  LSR	R9, R1				@ temp sine >> i
  SUB	R4, R4, R9			@ cosine = cosine - (temp sine >> i)
  ADD	R5, R5, R8			@ sine   = sine   + (temp cosine >> i)

  @MOV	R4, 10
  @MOV	R5, 11
  @SUB   R3, R3, R7          @ currAngle -= angles[i]
  @ASR   R5, R1				 @ shift right by 16 bits, not sure about arithmetic or logical
  @SUB   R4, R4, R5          @ newCos = currCos - (currSin * 2.0**(-i))
  @ASR   R4, R1
  @ADD   R5, R5, R4          @ newSin = currSin + (currCos * 2.0**(-i))
  @ MOV   R4, R8            @ store new values
  @ MOV   R5, R9

  ADD   R1, R1, #1          @ increment loop counter
  b for_loop


end:

 @LSR R4, #2
 @LSR R5, #2
 @FMSR S0, R4
 @FMSR S1, R5

  SWI   0x11
.end