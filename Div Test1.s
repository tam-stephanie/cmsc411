



@ R1/R2

mov R2, #60
MOV  R1,#128
 MOV  R0,R1,LSR#2 @shift R1 2 places
                  @to the right &
                  @store in R0
                  @answer now in R0

 CMP             R2, #0
 BEQ divide_end
 @check for divide by zero!				  
				  
				  
	

 MOV      R0,#0     @clear R0 to accumulate result
 MOV      R3,#1     @set bit 0 in R3, which will be
                    @shifted left then right
start:
 CMP      R2,R1
 MOVLS    R2,R2,LSL#1
 MOVLS    R3,R3,LSL#1
 BLS      start
 @shift R2 left until it is about to
 @be bigger than R1
 @shift R3 left in parallel in order
 @to flag how far we have to go





	
next:
 CMP       R1,R2      @carry set if R1>R2 (don't ask why)
 SUBCS     R1,R1,R2   @subtract R2 from R1 if this would
                      @give a positive answer
 ADDCS     R0,R0,R3   @and add the current bit in R3 to
                      @the accumulating answer in R0


 MOVS      R3,R3,LSR#1     @Shift R3 right into carry flag
 MOVCC     R2,R2,LSR#1     @and if bit 0 of R3 was zero, also
                           @shift R2 right
 BCC       next            @If carry not clear, R3 has shifted
                           @back to where it started, and we
                           @can end

divide_end:
 @MOV       R25, R24        @exit routine

@MOV R5, #5
@MOV R6, #3
@sdiv R5, R6


