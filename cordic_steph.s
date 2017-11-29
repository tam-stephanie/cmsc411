.data
currCos:   @ 0.6072529350 * 2^16
  .int  39796
currSin:
  .int  0

angles:   @ took original angles and manually multiplied by 2^16
  .int  2949120, 1740963, 919876, 466945, 234378, 117303, 58666, 29334, 14667, 7333, 3666, 1833

iter:     @ number of angles & iterations
  .int  12

currAngle:  @ z * 2^16
  @.int  5249433     @ z=80.1
  @.int  1587937     @ z=24.23
  .int  5898240     @ z=90.0

.text
main:
  LDR   R0, =iter           @ load & store number of iterations
  LDR   R2, [R0]
  SUB   R2, R2, #1          @ size - 1 to not go out-of-bounds
  MOV   R1, #0              @ for-loop counter, i

  LDR   R0, =currAngle      @ load & store currAngle
  LDR   R3, [R0]
  LDR   R0, =currCos        @ load & store currCos
  LDR   R4, [R0]
  LDR   R0, =currSin        @ load & store currSin
  LDR   R5, [R0]
  LDR   R0, =angles         @ load angles[]


for_loop:
  MOV   R6, R1
  LSL   R6, #2              @ offset by a byte
  LDR   R7, [R0, R6]        @ get angles[i]

  MOV   R8, R4              @ tempCos <-- currCos
  MOV   R9, R5              @ tempSin <-- currSin
  LSR   R8, R1              @ tempCos >> i
  LSR   R9, R1              @ tempSin >> i

  CMP   R3, #0              @ jump to appropriate section
  BGT   else

if:                         @ if currAngle <= 0
  ADD   R3, R3, R7          @ currAngle += angles[i]
  ADD   R4, R4, R9          @ currCos = currCos + tempSin
  SUB   R5, R5, R8          @ currSin = currSin - tempCos

  B     end_elif

else:                       @ if currAngle > 0
  SUB   R3, R3, R7          @ currAngle -= angles[i]
  SUB   R4, R4, R9          @ currCos = currCos - tempSin
  ADD   R5, R5, R8          @ currSin = currSin + tempCos

end_elif:
  ADD   R1, R1, #1          @ increment loop counter
  CMP   R1, R2              @ compare to make sure at right iteration
  BNE   for_loop

exit:
  SWI   0x11
