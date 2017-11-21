.data
GAIN_CONST:
  .float 0.60725

anglesTan:
  .float  45.0, 26.565, 14.0362, 7.12502, 3.57633
  .float	1.78991, 0.895174, 0.447614, 0.223811, 0.111906

iter:
  .int 10                   @ number of angles & iterations

currAngle:
  .float  80.1


.text
main:  
  LDR   R0, =iter           @ load addresses
  LDR   R2, [R0]            @ store number of iterations
  SUB   R2, R2, #1          @ for-loop counter

  LDR   R0, =currAngle      @ load address of angle
  LDR   R3, [R0]            @ store angle
