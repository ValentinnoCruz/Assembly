; Lab #5 Excersize 1: Arithmetic functions

.ORIG x3000
LDI R1, P		; load X into R1
LDI R2, Q		; load Y into R2
LDI R3, RES		; LOAD RES TO R3
NOT R2, R2		; 1ST COMPLIMENT OF Q
ADD R2, R2, X1		; 2S COMPLIMENT OF Q, R2 = -Q
ADD R4, R1, R2		; R4 = P - Q
STI R4, PMQ		; STORE R4 AT PMQ
BRp POS			; BRANCH IF POSITIVE GO TO POS
BRz ZERO		; BRANCH IF ZERO GO TO ZERO
BRn NEG			; BRANCH IF NEG GO TO NEG

POS
ADD R5, R3, X2		; IF POSITIVE ADD 2 TO RES
STI R5, RPOS		; STORE R5 TO RPOS
HALT

ZERO
ADD R5, R3, X1		; IF ZERO ADD 1 TO RES
STI R5, RZERO		; STORE R5 TO RZERO
HALT

NEG
ADD R6, R6, X1		; R6 = X1
NOT R6, R6		; 1S COMPLIMENT
ADD R6, R6, X1		; 2S COMPLIEMNT OF R6, -1
ADD R5, R3, R6		; R5 = RES - 1
STI R5, RNEG		; STORE R5 TO RNEG
HALT


P .FILL x3200		; FILL X WITH x3120
Q .FILL x3201		; FILL Y WITH x3121
RES .FILL x3202
PMQ .FILL x3203
RPOS .FILL x3204
RZERO .FILL x3205
RNEG .FILL x3206
.END			