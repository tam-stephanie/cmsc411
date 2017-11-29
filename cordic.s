.data
currCos:   @ 1.646768 * 2^16
  .int  107922
  1.646768
currSin:
  .int 0

angles:   @ took original angles and manually multiplied by 2^16
  .int  2949120, 170963, 919876, 466945, 234378, 117303,
  .int  58666, 29294, 14667, 7333

iter:
  .int 10                   @ number of angles & iterations

currAngle:  @ x * 2^16
  .int  5249433


.text
main:
  LDR   R0, =iter           @ load addresses
  LDR   R2, [R0]            @ store number of iterations
  SUB   R2, R2, #1
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

  ADD   R1, R1, #1          @ increment loop counter
  mov   R6, R1
  MOV   R7, [R0, R6]        @ get angles[i]

  CMP   R3, 0
  BG    else                @ jump to 'else' part

if:                         @ if currAngle <= 0
  ADD   R3, R3, R7          @ currAngle += angles[i]
  ASR   R5, 16              @ shift right by 16 bits, not sure about arithmetic or logical
  ADD   R8, R4, R5          @ newCos = currCos + (currSin * 2.0**(-i))

  ASR   R4, 16
  SUB   R9, R5, R4          @ newSin = currSin - (currCos * 2.0**(-i))

  LDR   R4, [R8]            @ store new values
  LDR   R5, [R9]

else:                       @ if currAngle > 0
  SUB   R3, R3, R7          @ currAngle += angles[i]
  ASR   R5, 16              @ shift right by 16 bits, not sure about arithmetic or logical
  SUB   R8, R4, R5          @ newCos = currCos - (currSin * 2.0**(-i))

  ASR   R4, 16
  ADD   R9, R5, R4          @ newSin = currSin + (currCos * 2.0**(-i))

  LDR   R4, [R8]            @ store new values
  LDR   R5, [R9]

end:
  SWI   0x11
